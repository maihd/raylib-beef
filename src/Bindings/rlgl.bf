/**********************************************************************************************
*
*   rlgl v4.5 - A multi-OpenGL abstraction layer with an immediate-mode style API
*
*   An abstraction layer for multiple OpenGL versions (1.1, 2.1, 3.3 Core, 4.3 Core, ES 2.0)
*   that provides a pseudo-OpenGL 1.1 immediate-mode style API (rlVertex, rlTranslate, rlRotate...)
*
*   When choosing an OpenGL backend different than OpenGL 1.1, some internal buffer are
*   initialized on rlglInit() to accumulate vertex data.
*
*   When an internal state change is required all the stored vertex data is renderer in batch,
*   additionally, rlDrawRenderBatchActive() could be called to force flushing of the batch.
*
*   Some additional resources are also loaded for convenience, here the complete list:
*      - Default batch (RLGL.defaultBatch): RenderBatch system to accumulate vertex data
*      - Default texture (RLGL.defaultTextureId): 1x1 white pixel R8G8B8A8
*      - Default shader (RLGL.State.defaultShaderId, RLGL.State.defaultShaderLocs)
*
*   Internal buffer (and additional resources) must be manually unloaded calling rlglClose().
*
*
*   CONFIGURATION:
*
*   #define GRAPHICS_API_OPENGL_11
*   #define GRAPHICS_API_OPENGL_21
*   #define GRAPHICS_API_OPENGL_33
*   #define GRAPHICS_API_OPENGL_43
*   #define GRAPHICS_API_OPENGL_ES2
*       Use selected OpenGL graphics backend, should be supported by platform
*       Those preprocessor defines are only used on rlgl module, if OpenGL version is
*       required by any other module, use rlGetVersion() to check it
*
*   #define RLGL_IMPLEMENTATION
*       Generates the implementation of the library into the included file.
*       If not defined, the library is in header only mode and can be included in other headers
*       or source files without problems. But only ONE file should hold the implementation.
*
*   #define RLGL_RENDER_TEXTURES_HINT
*       Enable framebuffer objects (fbo) support (enabled by default)
*       Some GPUs could not support them despite the OpenGL version
*
*   #define RLGL_SHOW_GL_DETAILS_INFO
*       Show OpenGL extensions and capabilities detailed logs on init
*
*   #define RLGL_ENABLE_OPENGL_DEBUG_CONTEXT
*       Enable debug context (only available on OpenGL 4.3)
*
*   rlgl capabilities could be customized just defining some internal
*   values before library inclusion (default values listed):
*
*   #define RL_DEFAULT_BATCH_BUFFER_ELEMENTS   8192    // Default internal render batch elements limits
*   #define RL_DEFAULT_BATCH_BUFFERS              1    // Default number of batch buffers (multi-buffering)
*   #define RL_DEFAULT_BATCH_DRAWCALLS          256    // Default number of batch draw calls (by state changes: mode, texture)
*   #define RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS    4    // Maximum number of textures units that can be activated on batch drawing (SetShaderValueTexture())
*
*   #define RL_MAX_MATRIX_STACK_SIZE             32    // Maximum size of internal Matrix stack
*   #define RL_MAX_SHADER_LOCATIONS              32    // Maximum number of shader locations supported
*   #define RL_CULL_DISTANCE_NEAR              0.01    // Default projection matrix near cull distance
*   #define RL_CULL_DISTANCE_FAR             1000.0    // Default projection matrix far cull distance
*
*   When loading a shader, the following vertex attribute and uniform
*   location names are tried to be set automatically:
*
*   #define RL_DEFAULT_SHADER_ATTRIB_NAME_POSITION     "vertexPosition"    // Bound by default to shader location: 0
*   #define RL_DEFAULT_SHADER_ATTRIB_NAME_TEXCOORD     "vertexTexCoord"    // Bound by default to shader location: 1
*   #define RL_DEFAULT_SHADER_ATTRIB_NAME_NORMAL       "vertexNormal"      // Bound by default to shader location: 2
*   #define RL_DEFAULT_SHADER_ATTRIB_NAME_COLOR        "vertexColor"       // Bound by default to shader location: 3
*   #define RL_DEFAULT_SHADER_ATTRIB_NAME_TANGENT      "vertexTangent"     // Bound by default to shader location: 4
*   #define RL_DEFAULT_SHADER_UNIFORM_NAME_MVP         "mvp"               // model-view-projection matrix
*   #define RL_DEFAULT_SHADER_UNIFORM_NAME_VIEW        "matView"           // view matrix
*   #define RL_DEFAULT_SHADER_UNIFORM_NAME_PROJECTION  "matProjection"     // projection matrix
*   #define RL_DEFAULT_SHADER_UNIFORM_NAME_MODEL       "matModel"          // model matrix
*   #define RL_DEFAULT_SHADER_UNIFORM_NAME_NORMAL      "matNormal"         // normal matrix (transpose(inverse(matModelView))
*   #define RL_DEFAULT_SHADER_UNIFORM_NAME_COLOR       "colDiffuse"        // color diffuse (base tint color, multiplied by texture color)
*   #define RL_DEFAULT_SHADER_SAMPLER2D_NAME_TEXTURE0  "texture0"          // texture0 (texture slot active 0)
*   #define RL_DEFAULT_SHADER_SAMPLER2D_NAME_TEXTURE1  "texture1"          // texture1 (texture slot active 1)
*   #define RL_DEFAULT_SHADER_SAMPLER2D_NAME_TEXTURE2  "texture2"          // texture2 (texture slot active 2)
*
*   DEPENDENCIES:
*
*      - OpenGL libraries (depending on platform and OpenGL version selected)
*      - GLAD OpenGL extensions loading library (only for OpenGL 3.3 Core, 4.3 Core)
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2014-2023 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/

using System.Text;
using System;
using System.Interop;

namespace Raylib
{
	// ----------------------------------------------------------------------------------
	// Types and Structures Definition
	// ----------------------------------------------------------------------------------

	// OpenGL version
	public enum rlGlVersion : int32
	{
		RL_OPENGL_11 = 1,           // OpenGL 1.1
		RL_OPENGL_21,               // OpenGL 2.1 (GLSL 120)
		RL_OPENGL_33,               // OpenGL 3.3 (GLSL 330)
		RL_OPENGL_43,               // OpenGL 4.3 (using GLSL 330)
		RL_OPENGL_ES_20             // OpenGL ES 2.0 (GLSL 100)
	}

	// Trace log level
	// NOTE: Organized by priority level
	public enum rlTraceLogLevel : int32
	{
	    RL_LOG_ALL = 0,             // Display all logs
	    RL_LOG_TRACE,               // Trace logging, intended for internal use only
	    RL_LOG_DEBUG,               // Debug logging, used for internal debugging, it should be disabled on release builds
	    RL_LOG_INFO,                // Info logging, used for program execution info
	    RL_LOG_WARNING,             // Warning logging, used on recoverable failures
	    RL_LOG_ERROR,               // Error logging, used on unrecoverable failures
	    RL_LOG_FATAL,               // Fatal logging, used to abort program: exit(EXIT_FAILURE)
	    RL_LOG_NONE                 // Disable logging
	}

	// Texture pixel formats
	// NOTE: Support depends on OpenGL version
	public enum rlPixelFormat : int32
	{
	    RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,     // 8 bit per pixel (no alpha)
	    RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,        // 8*2 bpp (2 channels)
	    RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5,            // 16 bpp
	    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8,            // 24 bpp
	    RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,          // 16 bpp (1 bit alpha)
	    RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,          // 16 bpp (4 bit alpha)
	    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,          // 32 bpp
	    RL_PIXELFORMAT_UNCOMPRESSED_R32,               // 32 bpp (1 channel - float)
	    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32,         // 32*3 bpp (3 channels - float)
	    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,      // 32*4 bpp (4 channels - float)
	    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB,            // 4 bpp (no alpha)
	    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA,           // 4 bpp (1 bit alpha)
	    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA,           // 8 bpp
	    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA,           // 8 bpp
	    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB,            // 4 bpp
	    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB,            // 4 bpp
	    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,       // 8 bpp
	    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB,            // 4 bpp
	    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA,           // 4 bpp
	    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,       // 8 bpp
	    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA        // 2 bpp
	}

	// Texture parameters: filter mode
	// NOTE 1: Filtering considers mipmaps if available in the texture
	// NOTE 2: Filter is accordingly set for minification and magnification
	public enum rlTextureFilter : int32
	{
	    RL_TEXTURE_FILTER_POINT = 0,        // No filter, just pixel approximation
	    RL_TEXTURE_FILTER_BILINEAR,         // Linear filtering
	    RL_TEXTURE_FILTER_TRILINEAR,        // Trilinear filtering (linear with mipmaps)
	    RL_TEXTURE_FILTER_ANISOTROPIC_4X,   // Anisotropic filtering 4x
	    RL_TEXTURE_FILTER_ANISOTROPIC_8X,   // Anisotropic filtering 8x
	    RL_TEXTURE_FILTER_ANISOTROPIC_16X,  // Anisotropic filtering 16x
	}

	// Color blending modes (pre-defined)
	public enum rlBlendMode : int32
	{
	    RL_BLEND_ALPHA = 0,                 // Blend textures considering alpha (default)
	    RL_BLEND_ADDITIVE,                  // Blend textures adding colors
	    RL_BLEND_MULTIPLIED,                // Blend textures multiplying colors
	    RL_BLEND_ADD_COLORS,                // Blend textures adding colors (alternative)
	    RL_BLEND_SUBTRACT_COLORS,           // Blend textures subtracting colors (alternative)
	    RL_BLEND_ALPHA_PREMULTIPLY,         // Blend premultiplied textures considering alpha
	    RL_BLEND_CUSTOM,                    // Blend textures using custom src/dst factors (use rlSetBlendFactors())
	    RL_BLEND_CUSTOM_SEPARATE            // Blend textures using custom src/dst factors (use rlSetBlendFactorsSeparate())
	}

	// Shader location point type
	[AllowDuplicates]
	public enum rlShaderLocationIndex : int32
	{
	    RL_SHADER_LOC_VERTEX_POSITION = 0,  // Shader location: vertex attribute: position
	    RL_SHADER_LOC_VERTEX_TEXCOORD01,    // Shader location: vertex attribute: texcoord01
	    RL_SHADER_LOC_VERTEX_TEXCOORD02,    // Shader location: vertex attribute: texcoord02
	    RL_SHADER_LOC_VERTEX_NORMAL,        // Shader location: vertex attribute: normal
	    RL_SHADER_LOC_VERTEX_TANGENT,       // Shader location: vertex attribute: tangent
	    RL_SHADER_LOC_VERTEX_COLOR,         // Shader location: vertex attribute: color
	    RL_SHADER_LOC_MATRIX_MVP,           // Shader location: matrix uniform: model-view-projection
	    RL_SHADER_LOC_MATRIX_VIEW,          // Shader location: matrix uniform: view (camera transform)
	    RL_SHADER_LOC_MATRIX_PROJECTION,    // Shader location: matrix uniform: projection
	    RL_SHADER_LOC_MATRIX_MODEL,         // Shader location: matrix uniform: model (transform)
	    RL_SHADER_LOC_MATRIX_NORMAL,        // Shader location: matrix uniform: normal
	    RL_SHADER_LOC_VECTOR_VIEW,          // Shader location: vector uniform: view
	    RL_SHADER_LOC_COLOR_DIFFUSE,        // Shader location: vector uniform: diffuse color
	    RL_SHADER_LOC_COLOR_SPECULAR,       // Shader location: vector uniform: specular color
	    RL_SHADER_LOC_COLOR_AMBIENT,        // Shader location: vector uniform: ambient color
	    RL_SHADER_LOC_MAP_ALBEDO,           // Shader location: sampler2d texture: albedo (same as: RL_SHADER_LOC_MAP_DIFFUSE)
	    RL_SHADER_LOC_MAP_METALNESS,        // Shader location: sampler2d texture: metalness (same as: RL_SHADER_LOC_MAP_SPECULAR)
	    RL_SHADER_LOC_MAP_NORMAL,           // Shader location: sampler2d texture: normal
	    RL_SHADER_LOC_MAP_ROUGHNESS,        // Shader location: sampler2d texture: roughness
	    RL_SHADER_LOC_MAP_OCCLUSION,        // Shader location: sampler2d texture: occlusion
	    RL_SHADER_LOC_MAP_EMISSION,         // Shader location: sampler2d texture: emission
	    RL_SHADER_LOC_MAP_HEIGHT,           // Shader location: sampler2d texture: height
	    RL_SHADER_LOC_MAP_CUBEMAP,          // Shader location: samplerCube texture: cubemap
	    RL_SHADER_LOC_MAP_IRRADIANCE,       // Shader location: samplerCube texture: irradiance
	    RL_SHADER_LOC_MAP_PREFILTER,        // Shader location: samplerCube texture: prefilter
	    RL_SHADER_LOC_MAP_BRDF,             // Shader location: sampler2d texture: brdf

		RL_SHADER_LOC_MAP_DIFFUSE = RL_SHADER_LOC_MAP_ALBEDO,
		RL_SHADER_LOC_MAP_SPECULAR = RL_SHADER_LOC_MAP_METALNESS
	}

	// Shader uniform data type
	public enum rlShaderUniformDataType : int32
	{
	    RL_SHADER_UNIFORM_FLOAT = 0,        // Shader uniform type: float
	    RL_SHADER_UNIFORM_VEC2,             // Shader uniform type: vec2 (2 float)
	    RL_SHADER_UNIFORM_VEC3,             // Shader uniform type: vec3 (3 float)
	    RL_SHADER_UNIFORM_VEC4,             // Shader uniform type: vec4 (4 float)
	    RL_SHADER_UNIFORM_INT,              // Shader uniform type: int
	    RL_SHADER_UNIFORM_IVEC2,            // Shader uniform type: ivec2 (2 int)
	    RL_SHADER_UNIFORM_IVEC3,            // Shader uniform type: ivec3 (3 int)
	    RL_SHADER_UNIFORM_IVEC4,            // Shader uniform type: ivec4 (4 int)
	    RL_SHADER_UNIFORM_SAMPLER2D         // Shader uniform type: sampler2d
	}

	// Shader attribute data types
	public enum rlShaderAttributeDataType : int32
	{
	    RL_SHADER_ATTRIB_FLOAT = 0,         // Shader attribute type: float
	    RL_SHADER_ATTRIB_VEC2,              // Shader attribute type: vec2 (2 float)
	    RL_SHADER_ATTRIB_VEC3,              // Shader attribute type: vec3 (3 float)
	    RL_SHADER_ATTRIB_VEC4               // Shader attribute type: vec4 (4 float)
	}

	// Framebuffer attachment type
	// NOTE: By default up to 8 color channels defined, but it can be more
	public enum rlFramebufferAttachType : int32
	{
	    RL_ATTACHMENT_COLOR_CHANNEL0 = 0,   // Framebuffer attachment type: color 0
	    RL_ATTACHMENT_COLOR_CHANNEL1,       // Framebuffer attachment type: color 1
	    RL_ATTACHMENT_COLOR_CHANNEL2,       // Framebuffer attachment type: color 2
	    RL_ATTACHMENT_COLOR_CHANNEL3,       // Framebuffer attachment type: color 3
	    RL_ATTACHMENT_COLOR_CHANNEL4,       // Framebuffer attachment type: color 4
	    RL_ATTACHMENT_COLOR_CHANNEL5,       // Framebuffer attachment type: color 5
	    RL_ATTACHMENT_COLOR_CHANNEL6,       // Framebuffer attachment type: color 6
	    RL_ATTACHMENT_COLOR_CHANNEL7,       // Framebuffer attachment type: color 7
	    RL_ATTACHMENT_DEPTH = 100,          // Framebuffer attachment type: depth
	    RL_ATTACHMENT_STENCIL = 200,        // Framebuffer attachment type: stencil
	}

	// Framebuffer texture attachment type
	public enum rlFramebufferAttachTextureType : int32
	{
	    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0, // Framebuffer texture attachment type: cubemap, +X side
	    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X,   // Framebuffer texture attachment type: cubemap, -X side
	    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y,   // Framebuffer texture attachment type: cubemap, +Y side
	    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y,   // Framebuffer texture attachment type: cubemap, -Y side
	    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z,   // Framebuffer texture attachment type: cubemap, +Z side
	    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z,   // Framebuffer texture attachment type: cubemap, -Z side
	    RL_ATTACHMENT_TEXTURE2D = 100,      // Framebuffer texture attachment type: texture2d
	    RL_ATTACHMENT_RENDERBUFFER = 200,   // Framebuffer texture attachment type: renderbuffer
	}

	// Face culling mode
	public enum rlCullMode : int32
	{
	    RL_CULL_FACE_FRONT = 0,
	    RL_CULL_FACE_BACK
	}

	// Dynamic vertex buffers (position + texcoords + colors + indices arrays)
	[CRepr]
	public struct rlVertexBuffer
	{
	    public int32 		elementCount;		// Number of elements in the buffer (QUADS)
	
	    public float* 		vertices;           // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	    public float* 		texcoords;          // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	    public uint8* 		colors;      		// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
	#if BF_PLATFORM_WINDOWS || BF_PLATFORM_LINUX || BF_PLATFORM_MACOS
	    public uint32* 		indices;      		// Vertex indices (in case vertex data comes indexed) (6 indices per quad)
	#endif
	#if BF_PLATFORM_ANDROID || BF_PLATFORM_WEB || BF_PLATFORM_IOS
	    public uint16* 		indices;    		// Vertex indices (in case vertex data comes indexed) (6 indices per quad)
	#endif
	    public uint32 		vaoId;         		// OpenGL Vertex Array Object id
	    public uint32[4] 	vboId;      		// OpenGL Vertex Buffer Objects id (4 types of vertex data)
	}

	// Draw call type
	// NOTE: Only texture changes register a new draw, other state-change-related elements are not
	// used at this moment (vaoId, shaderId, matrices), raylib just forces a batch draw call if any
	// of those state-change happens (this is done in core module)
	[CRepr]
	public struct rlDrawCall
	{
	    public int32		mode;                   // Drawing mode: LINES, TRIANGLES, QUADS
	    public int32 		vertexCount;            // Number of vertex of the draw
	    public int32 		vertexAlignment;        // Number of vertex required for index alignment (LINES, TRIANGLES)
	    //public uint32 	vaoId;       			// Vertex array id to be used on the draw -> Using RLGL.currentBatch->vertexBuffer.vaoId
	    //public uint32 	shaderId;    			// Shader id to be used on the draw -> Using RLGL.currentShaderId
	    public uint32 		textureId;     			// Texture id to be used on the draw -> Use to create new draw call if changes

	    //public Matrix 	projection;        		// Projection matrix for this draw -> Using RLGL.projection by default
	    //public Matrix 	modelview;         		// Modelview matrix for this draw -> Using RLGL.modelview by default
	}

	// rlRenderBatch type
	struct rlRenderBatch
	{
	    public int32 			bufferCount;        // Number of vertex buffers (multi-buffering support)
	    public int32 			currentBuffer;      // Current buffer tracking in case of multi-buffering
	    public rlVertexBuffer* 	vertexBuffer; 		// Dynamic buffer(s) for vertex data

	    public rlDrawCall* 		draws;          	// Draw calls array, depends on textureId
	    public int32 			drawCounter;        // Draw calls counter
	    public float 			currentDepth;       // Current depth value for next draw
	}

	public static
	{
		//----------------------------------------------------------------------------------
		// Defines and Macros
		//----------------------------------------------------------------------------------

		// Used by Import to load the native library.
		public const String nativeLibName = "raylib.dll";
		
		// Texture parameters (equivalent to OpenGL defines)
		public const int RL_TEXTURE_WRAP_S 						= 0x2802;	// GL_TEXTURE_WRAP_S
		public const int RL_TEXTURE_WRAP_T 						= 0x2803;	// GL_TEXTURE_WRAP_T
		public const int RL_TEXTURE_MAG_FILTER 					= 0x2800;	// GL_TEXTURE_MAG_FILTER
		public const int RL_TEXTURE_MIN_FILTER 					= 0x2801;	// GL_TEXTURE_MIN_FILTER
		
		public const int RL_TEXTURE_FILTER_NEAREST 				= 0x2600;	// GL_NEAREST
		public const int RL_TEXTURE_FILTER_LINEAR 				= 0x2601;	// GL_LINEAR
		public const int RL_TEXTURE_FILTER_MIP_NEAREST 			= 0x2700;	// GL_NEAREST_MIPMAP_NEAREST
		public const int RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR 	= 0x2702;	// GL_NEAREST_MIPMAP_LINEAR
		public const int RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST 	= 0x2701;	// GL_LINEAR_MIPMAP_NEAREST
		public const int RL_TEXTURE_FILTER_MIP_LINEAR 			= 0x2703;	// GL_LINEAR_MIPMAP_LINEAR
		public const int RL_TEXTURE_FILTER_ANISOTROPIC 			= 0x3000;	// Anisotropic filter (custom identifier)
		public const int RL_TEXTURE_MIPMAP_BIAS_RATIO 			= 0x4000;	// Texture mipmap bias, percentage ratio (custom identifier)

		public const int RL_WRAP_REPEAT 						= 0x2901;	// GL_REPEAT
		public const int RL_WRAP_CLAMP 							= 0x812F;	// GL_CLAMP_TO_EDGE
		public const int RL_WRAP_MIRROR_REPEAT 					= 0x8370;	// GL_MIRRORED_REPEAT
		public const int RL_WRAP_MIRROR_CLAMP 					= 0x8742;	// GL_MIRROR_CLAMP_EXT
		
		// Matrix modes (equivalent to OpenGL)
		public const int RL_MODELVIEW 							= 0x1700;	// GL_MODELVIEW
		public const int RL_PROJECTION 							= 0x1701;	// GL_PROJECTION
		public const int RL_TEXTURE 							= 0x1702;	// GL_TEXTURE
		
		// Primitive assembly draw modes
		public const int RL_LINES 								= 0x0001;	// GL_LINES
		public const int RL_TRIANGLES 							= 0x0004;	// GL_TRIANGLES
		public const int RL_QUADS 								= 0x0007;	// GL_QUADS

		// GL equivalent data types
		public const int RL_UNSIGNED_BYTE 						= 0x1401;	// GL_UNSIGNED_BYTE
		public const int RL_FLOAT 								= 0x1406;	// GL_FLOAT
		
		// GL buffer usage hint
		public const int RL_STREAM_DRAW 						= 0x88E0;	// GL_STREAM_DRAW
		public const int RL_STREAM_READ 						= 0x88E1;	// GL_STREAM_READ
		public const int RL_STREAM_COPY 						= 0x88E2;	// GL_STREAM_COPY
		public const int RL_STATIC_DRAW 						= 0x88E4;	// GL_STATIC_DRAW
		public const int RL_STATIC_READ 						= 0x88E5;	// GL_STATIC_READ
		public const int RL_STATIC_COPY 						= 0x88E6;	// GL_STATIC_COPY
		public const int RL_DYNAMIC_DRAW 						= 0x88E8;	// GL_DYNAMIC_DRAW
		public const int RL_DYNAMIC_READ 						= 0x88E9;	// GL_DYNAMIC_READ
		public const int RL_DYNAMIC_COPY 						= 0x88EA;	// GL_DYNAMIC_COPY

		// GL Shader type
		public const int RL_FRAGMENT_SHADER 					= 0x8B30;	// GL_FRAGMENT_SHADER
		public const int RL_VERTEX_SHADER 						= 0x8B31;	// GL_VERTEX_SHADER
		public const int RL_COMPUTE_SHADER 						= 0x91B9;	// GL_COMPUTE_SHADER

		// GL blending factors
		public const int RL_ZERO 								= 0x0000;	// GL_ZERO
		public const int RL_ONE 								= 0x0001;	// GL_ONE
		public const int RL_SRC_COLOR 							= 0x0300;	// GL_SRC_COLOR
		public const int RL_ONE_MINUS_SRC_COLOR 				= 0x0301;	// GL_ONE_MINUS_SRC_COLOR
		public const int RL_SRC_ALPHA 							= 0x0302;	// GL_SRC_ALPHA
		public const int RL_ONE_MINUS_SRC_ALPHA 				= 0x0303;	// GL_ONE_MINUS_SRC_ALPHA
		public const int RL_DST_ALPHA 							= 0x0304;	// GL_DST_ALPHA
		public const int RL_ONE_MINUS_DST_ALPHA 				= 0x0305;	// GL_ONE_MINUS_DST_ALPHA
		public const int RL_DST_COLOR 							= 0x0306;	// GL_DST_COLOR
		public const int RL_ONE_MINUS_DST_COLOR 				= 0x0307;	// GL_ONE_MINUS_DST_COLOR
		public const int RL_SRC_ALPHA_SATURATE 					= 0x0308;	// GL_SRC_ALPHA_SATURATE
		public const int RL_CONSTANT_COLOR 						= 0x8001;	// GL_CONSTANT_COLOR
		public const int RL_ONE_MINUS_CONSTANT_COLOR 			= 0x8002;	// GL_ONE_MINUS_CONSTANT_COLOR
		public const int RL_CONSTANT_ALPHA 						= 0x8003;	// GL_CONSTANT_ALPHA
		public const int RL_ONE_MINUS_CONSTANT_ALPHA 			= 0x8004;	// GL_ONE_MINUS_CONSTANT_ALPHA

		// GL blending functions/equations
		public const int RL_FUNC_ADD 							= 0x8006;	// GL_FUNC_ADD
		public const int RL_MIN                   				= 0x8007;	// GL_MIN
		public const int RL_MAX                   				= 0x8008;	// GL_MAX
		public const int RL_FUNC_SUBTRACT         				= 0x800A;	// GL_FUNC_SUBTRACT
		public const int RL_FUNC_REVERSE_SUBTRACT 				= 0x800B;	// GL_FUNC_REVERSE_SUBTRACT
		public const int RL_BLEND_EQUATION        				= 0x8009;	// GL_BLEND_EQUATION
		public const int RL_BLEND_EQUATION_RGB    				= 0x8009;	// GL_BLEND_EQUATION_RGB   // (Same as BLEND_EQUATI
		public const int RL_BLEND_EQUATION_ALPHA  				= 0x883D;	// GL_BLEND_EQUATION_ALPHA
		public const int RL_BLEND_DST_RGB         				= 0x80C8;	// GL_BLEND_DST_RGB
		public const int RL_BLEND_SRC_RGB         				= 0x80C9;	// GL_BLEND_SRC_RGB
		public const int RL_BLEND_DST_ALPHA       				= 0x80CA;	// GL_BLEND_DST_ALPHA
		public const int RL_BLEND_SRC_ALPHA       				= 0x80CB;	// GL_BLEND_SRC_ALPHA
		public const int RL_BLEND_COLOR           				= 0x8005;	// GL_BLEND_COLOR
		
		public const float MAX_BATCH_ELEMENTS = 8192;
		public const float MAX_BATCH_BUFFERING = 1;
		public const float MAX_MATRIX_STACK_SIZE = 32;
		public const float MAX_DRAWCALL_REGISTERED = 256;
		public const float DEFAULT_NEAR_CULL_DISTANCE = 0.01f;
		public const float DEFAULT_FAR_CULL_DISTANCE = 1000.0f;

		// ------------------------------------------------------------------------------------
		// Functions Declaration - Matrix operations
		// ------------------------------------------------------------------------------------

		[CLink]
		public static extern void rlMatrixMode(int mode);                    // Choose the current matrix to be transformed
		[CLink]
		public static extern void rlPushMatrix();                        // Push the current matrix to stack
		[CLink]
		public static extern void rlPopMatrix();                         // Pop latest inserted matrix from stack
		[CLink]
		public static extern void rlLoadIdentity();                      // Reset current matrix to identity matrix
		[CLink]
		public static extern void rlTranslatef(float x, float y, float z);   // Multiply the current matrix by a translation matrix
		[CLink]
		public static extern void rlRotatef(float angle, float x, float y, float z);  // Multiply the current matrix by a rotation matrix
		[CLink]
		public static extern void rlScalef(float x, float y, float z);       // Multiply the current matrix by a scaling matrix
		[CLink]
		public static extern void rlMultMatrixf(float* matf);                // Multiply the current matrix by another matrix
		[CLink]
		public static extern void rlFrustum(double left, double right, double bottom, double top, double znear, double zfar);
		[CLink]
		public static extern void rlOrtho(double left, double right, double bottom, double top, double znear, double zfar);
		[CLink]
		public static extern void rlViewport(int x, int y, int width, int height); // Set the viewport area

		//------------------------------------------------------------------------------------
		// Functions Declaration - Vertex level operations
		//------------------------------------------------------------------------------------
		[CLink]
		public static extern void rlBegin(int mode);                         // Initialize drawing mode (how to organize vertex)
		[CLink]
		public static extern void rlEnd();                               // Finish vertex providing
		[CLink]
		public static extern void rlVertex2i(int x, int y);                  // Define one vertex (position) - 2 int
		[CLink]
		public static extern void rlVertex2f(float x, float y);              // Define one vertex (position) - 2 float
		[CLink]
		public static extern void rlVertex3f(float x, float y, float z);     // Define one vertex (position) - 3 float
		[CLink]
		public static extern void rlTexCoord2f(float x, float y);            // Define one vertex (texture coordinate) - 2 float
		[CLink]
		public static extern void rlNormal3f(float x, float y, float z);     // Define one vertex (normal) - 3 float
		[CLink]
		public static extern void rlColor4ub(uint8 r, uint8 g, uint8 b, uint8 a);  // Define one vertex (color) - 4 byte
		[CLink]
		public static extern void rlColor3f(float x, float y, float z);          // Define one vertex (color) - 3 float
		[CLink]
		public static extern void rlColor4f(float x, float y, float z, float w); // Define one vertex (color) - 4 float

		//------------------------------------------------------------------------------------
		// Functions Declaration - OpenGL style functions (common to 1.1, 3.3+, ES2)
		// NOTE: This functions are used to completely abstract raylib code from OpenGL layer,
		// some of them are direct wrappers over OpenGL calls, some others are custom
		//------------------------------------------------------------------------------------

		// Vertex buffers state
		[CLink]
		public static extern bool rlEnableVertexArray(uint32 vaoId);     // Enable vertex array (VAO, if supported)
		[CLink]
		public static extern void rlDisableVertexArray();                  // Disable vertex array (VAO, if supported)
		[CLink]
		public static extern void rlEnableVertexBuffer(uint32 id);       // Enable vertex buffer (VBO)
		[CLink]
		public static extern void rlDisableVertexBuffer();                 // Disable vertex buffer (VBO)
		[CLink]
		public static extern void rlEnableVertexBufferElement(uint32 id);// Enable vertex buffer element (VBO element)
		[CLink]
		public static extern void rlDisableVertexBufferElement();          // Disable vertex buffer element (VBO element)
		[CLink]
		public static extern void rlEnableVertexAttribute(uint32 index); // Enable vertex attribute index
		[CLink]
		public static extern void rlDisableVertexAttribute(uint32 index);// Disable vertex attribute index

/*
#if defined(GRAPHICS_API_OPENGL_11)
		[CLink]
		public static extern void rlEnableStatePointer(int vertexAttribType, void *buffer);    // Enable attribute state pointer
		[CLink]
		public static extern void rlDisableStatePointer(int vertexAttribType);                 // Disable attribute state pointer
#endif
*/

		// Textures state
		[CLink]
		public static extern void rlActiveTextureSlot(int slot);               // Select and active a texture slot
		[CLink]
		public static extern void rlEnableTexture(uint32 id);            // Enable texture
		[CLink]
		public static extern void rlDisableTexture();                      // Disable texture
		[CLink]
		public static extern void rlEnableTextureCubemap(uint32 id);     // Enable texture cubemap
		[CLink]
		public static extern void rlDisableTextureCubemap();               // Disable texture cubemap
		[CLink]
		public static extern void rlTextureParameters(uint32 id, int param, int value); // Set texture parameters (filter, wrap)
		[CLink]
		public static extern void rlCubemapParameters(uint32 id, int param, int value); // Set cubemap parameters (filter, wrap)

		// Shader state
		[CLink]
		public static extern void rlEnableShader(uint32 id);             // Enable shader program
		[CLink]
		public static extern void rlDisableShader();                       // Disable shader program

		// Framebuffer state
		[CLink]
		public static extern void rlEnableFramebuffer(uint32 id);        // Enable render texture (fbo)
		[CLink]
		public static extern void rlDisableFramebuffer();                  // Disable render texture (fbo), return to default framebuffer
		[CLink]
		public static extern void rlActiveDrawBuffers(int count);              // Activate multiple draw color buffers

		// General render state
		[CLink]
		public static extern void rlEnableColorBlend();                     // Enable color blending
		[CLink]
		public static extern void rlDisableColorBlend();                   // Disable color blending
		[CLink]
		public static extern void rlEnableDepthTest();                     // Enable depth test
		[CLink]
		public static extern void rlDisableDepthTest();                    // Disable depth test
		[CLink]
		public static extern void rlEnableDepthMask();                     // Enable depth write
		[CLink]
		public static extern void rlDisableDepthMask();                    // Disable depth write
		[CLink]
		public static extern void rlEnableBackfaceCulling();               // Enable backface culling
		[CLink]
		public static extern void rlDisableBackfaceCulling();              // Disable backface culling
		[CLink]
		public static extern void rlSetCullFace(int mode);                     // Set face culling mode
		[CLink]
		public static extern void rlEnableScissorTest();                   // Enable scissor test
		[CLink]
		public static extern void rlDisableScissorTest();                  // Disable scissor test
		[CLink]
		public static extern void rlScissor(int x, int y, int width, int height); // Scissor test
		[CLink]
		public static extern void rlEnableWireMode();                      // Enable wire mode
		[CLink]
		public static extern void rlDisableWireMode();                     // Disable wire mode
		[CLink]
		public static extern void rlSetLineWidth(float width);                 // Set the line drawing width
		[CLink]
		public static extern float rlGetLineWidth();                       // Get the line drawing width
		[CLink]
		public static extern void rlEnableSmoothLines();                   // Enable line aliasing
		[CLink]
		public static extern void rlDisableSmoothLines();                  // Disable line aliasing
		[CLink]
		public static extern void rlEnableStereoRender();                  // Enable stereo rendering
		[CLink]
		public static extern void rlDisableStereoRender();                 // Disable stereo rendering
		[CLink]
		public static extern bool rlIsStereoRenderEnabled();               // Check if stereo render is enabled

		[CLink]
		public static extern void rlClearColor(uint8 r, uint8 g, uint8 b, uint8 a); // Clear color buffer with color
		[CLink]
		public static extern void rlClearScreenBuffers();                  // Clear used screen buffers (color and depth)
		[CLink]
		public static extern void rlCheckErrors();                         // Check and log OpenGL error codes
		[CLink]
		public static extern void rlSetBlendMode(int mode);                    // Set blending mode
		[CLink]
		public static extern void rlSetBlendFactors(int glSrcFactor, int glDstFactor, int glEquation); // Set blending mode factor and equation (using OpenGL factors)
		[CLink]
		public static extern void rlSetBlendFactorsSeparate(int glSrcRGB, int glDstRGB, int glSrcAlpha, int glDstAlpha, int glEqRGB, int glEqAlpha); // Set blending mode factors and equations separately (using OpenGL factors)

		//------------------------------------------------------------------------------------
		// Functions Declaration - rlgl functionality
		//------------------------------------------------------------------------------------
		// rlgl initialization functions
		[CLink]
		public static extern void rlglInit(int width, int height);             // Initialize rlgl (buffers, shaders, textures, states)
		[CLink]
		public static extern void rlglClose();                             // De-initialize rlgl (buffers, shaders, textures)
		[CLink]
		public static extern void rlLoadExtensions(void *loader);              // Load OpenGL extensions (loader function required)
		[CLink]
		public static extern int rlGetVersion();                           // Get current OpenGL version
		[CLink]
		public static extern void rlSetFramebufferWidth(int width);            // Set current framebuffer width
		[CLink]
		public static extern int rlGetFramebufferWidth();                  // Get default framebuffer width
		[CLink]
		public static extern void rlSetFramebufferHeight(int height);          // Set current framebuffer height
		[CLink]
		public static extern int rlGetFramebufferHeight();                 // Get default framebuffer height

		[CLink]
		public static extern uint32 rlGetTextureIdDefault();         // Get default texture id
		[CLink]
		public static extern uint32 rlGetShaderIdDefault();          // Get default shader id
		[CLink]
		public static extern int *rlGetShaderLocsDefault();                // Get default shader locations

		// Render batch management
		// NOTE: rlgl provides a default render batch to behave like OpenGL 1.1 immediate mode
		// but this render batch API is exposed in case of custom batches are required
		[CLink]
		public static extern rlRenderBatch rlLoadRenderBatch(int numBuffers, int bufferElements);  // Load a render batch system
		[CLink]
		public static extern void rlUnloadRenderBatch(rlRenderBatch batch);                        // Unload render batch system
		[CLink]
		public static extern void rlDrawRenderBatch(rlRenderBatch *batch);                         // Draw render batch data (Update->Draw->Reset)
		[CLink]
		public static extern void rlSetRenderBatchActive(rlRenderBatch *batch);                    // Set the active render batch for rlgl (NULL for default internal)
		[CLink]
		public static extern void rlDrawRenderBatchActive();                                   // Update and draw internal render batch
		[CLink]
		public static extern bool rlCheckRenderBatchLimit(int vCount);                             // Check internal buffer overflow for a given number of vertex

		[CLink]
		public static extern void rlSetTexture(uint32 id);               // Set current texture for render batch and check buffers limits

		//------------------------------------------------------------------------------------------------------------------------

		// Vertex buffers management
		[CLink]
		public static extern uint32 rlLoadVertexArray();                               // Load vertex array (vao) if supported
		[CLink]
		public static extern uint32 rlLoadVertexBuffer(void* buffer, int size, bool dynamic);            // Load a vertex buffer attribute
		[CLink]
		public static extern uint32 rlLoadVertexBufferElement(void* buffer, int size, bool dynamic);     // Load a new attributes element buffer
		[CLink]
		public static extern void rlUpdateVertexBuffer(uint32 bufferId, void* data, int dataSize, int offset);     // Update GPU buffer with new data
		[CLink]
		public static extern void rlUpdateVertexBufferElements(uint32 id, void* data, int dataSize, int offset);   // Update vertex buffer elements with new data
		[CLink]
		public static extern void rlUnloadVertexArray(uint32 vaoId);
		[CLink]
		public static extern void rlUnloadVertexBuffer(uint32 vboId);
		[CLink]
		public static extern void rlSetVertexAttribute(uint32 index, int compSize, int type, bool normalized, int stride, void* pointer);
		[CLink]
		public static extern void rlSetVertexAttributeDivisor(uint32 index, int divisor);
		[CLink]
		public static extern void rlSetVertexAttributeDefault(int locIndex, void* value, int attribType, int count); // Set vertex attribute default value
		[CLink]
		public static extern void rlDrawVertexArray(int offset, int count);
		[CLink]
		public static extern void rlDrawVertexArrayElements(int offset, int count, void* buffer);
		[CLink]
		public static extern void rlDrawVertexArrayInstanced(int offset, int count, int instances);
		[CLink]
		public static extern void rlDrawVertexArrayElementsInstanced(int offset, int count, void* buffer, int instances);

		// Textures management
		[CLink]
		public static extern uint32 rlLoadTexture(void* data, int width, int height, int format, int mipmapCount); // Load texture in GPU
		[CLink]
		public static extern uint32 rlLoadTextureDepth(int width, int height, bool useRenderBuffer);               // Load depth texture/renderbuffer (to be attached to fbo)
		[CLink]
		public static extern uint32 rlLoadTextureCubemap(void* data, int size, int format);                        // Load texture cubemap
		[CLink]
		public static extern void rlUpdateTexture(uint32 id, int offsetX, int offsetY, int width, int height, int format, void* data);  // Update GPU texture with new data
		[CLink]
		public static extern void rlGetGlTextureFormats(int format, uint32 *glInternalFormat, uint32 *glFormat, uint32 *glType);  // Get OpenGL internal formats
		[CLink]
		public static extern char8* rlGetPixelFormatName(uint32 format);              // Get name string for pixel format
		[CLink]
		public static extern void rlUnloadTexture(uint32 id);                              // Unload texture from GPU memory
		[CLink]
		public static extern void rlGenTextureMipmaps(uint32 id, int width, int height, int format, int *mipmaps); // Generate mipmap data for selected texture
		[CLink]
		public static extern void *rlReadTexturePixels(uint32 id, int width, int height, int format);              // Read texture pixel data
		[CLink]
		public static extern uint8* rlReadScreenPixels(int width, int height);           // Read screen pixel data (color buffer)

		// Framebuffer management (fbo)
		[CLink]
		public static extern uint32 rlLoadFramebuffer(int width, int height);              // Load an empty framebuffer
		[CLink]
		public static extern void rlFramebufferAttach(uint32 fboId, uint32 texId, int attachType, int texType, int mipLevel);  // Attach texture/renderbuffer to a framebuffer
		[CLink]
		public static extern bool rlFramebufferComplete(uint32 id);                        // Verify framebuffer is complete
		[CLink]
		public static extern void rlUnloadFramebuffer(uint32 id);                          // Delete framebuffer from GPU

		// Shaders management
		[CLink]
		public static extern uint32 rlLoadShaderCode(char8* vsCode, char8* fsCode);    // Load shader from code strings
		[CLink]
		public static extern uint32 rlCompileShader(char8* shaderCode, int type);           // Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
		[CLink]
		public static extern uint32 rlLoadShaderProgram(uint32 vShaderId, uint32 fShaderId); // Load custom shader program
		[CLink]
		public static extern void rlUnloadShaderProgram(uint32 id);                              // Unload shader program
		[CLink]
		public static extern int rlGetLocationUniform(uint32 shaderId, char8* uniformName); // Get shader location uniform
		[CLink]
		public static extern int rlGetLocationAttrib(uint32 shaderId, char8* attribName);   // Get shader location attribute
		[CLink]
		public static extern void rlSetUniform(int locIndex, void* value, int uniformType, int count);   // Set shader value uniform
		[CLink]
		public static extern void rlSetUniformMatrix(int locIndex, Matrix mat);                        // Set shader value matrix
		[CLink]
		public static extern void rlSetUniformSampler(int locIndex, uint32 textureId);           // Set shader value sampler
		[CLink]
		public static extern void rlSetShader(uint32 id, int *locs);                             // Set shader currently active (id and locations)

		// Compute shader management
		[CLink]
		public static extern uint32 rlLoadComputeShaderProgram(uint32 shaderId);           // Load compute shader program
		[CLink]
		public static extern void rlComputeShaderDispatch(uint32 groupX, uint32 groupY, uint32 groupZ);  // Dispatch compute shader (equivalent to *draw* for graphics pipeline)

		// Shader buffer storage object management (ssbo)
		[CLink]
		public static extern uint32 rlLoadShaderBuffer(uint32 size, void* data, int usageHint); // Load shader storage buffer object (SSBO)
		[CLink]
		public static extern void rlUnloadShaderBuffer(uint32 ssboId);                           // Unload shader storage buffer object (SSBO)
		[CLink]
		public static extern void rlUpdateShaderBuffer(uint32 id, void* data, uint32 dataSize, uint32 offset); // Update SSBO buffer data
		[CLink]
		public static extern void rlBindShaderBuffer(uint32 id, uint32 index);             // Bind SSBO buffer
		[CLink]
		public static extern void rlReadShaderBuffer(uint32 id, void *dest, uint32 count, uint32 offset); // Read SSBO buffer data (GPU->CPU)
		[CLink]
		public static extern void rlCopyShaderBuffer(uint32 destId, uint32 srcId, uint32 destOffset, uint32 srcOffset, uint32 count); // Copy SSBO data between buffers
		[CLink]
		public static extern uint32 rlGetShaderBufferSize(uint32 id);                      // Get SSBO buffer size

		// Buffer management
		[CLink]
		public static extern void rlBindImageTexture(uint32 id, uint32 index, int format, bool @readonly);  // Bind image texture

		// Matrix state management
		[CLink]
		public static extern Matrix rlGetMatrixModelview();                                  // Get internal modelview matrix
		[CLink]
		public static extern Matrix rlGetMatrixProjection();                                 // Get internal projection matrix
		[CLink]
		public static extern Matrix rlGetMatrixTransform();                                  // Get internal accumulated transform matrix
		[CLink]
		public static extern Matrix rlGetMatrixProjectionStereo(int eye);                        // Get internal projection matrix for stereo render (selected eye)
		[CLink]
		public static extern Matrix rlGetMatrixViewOffsetStereo(int eye);                        // Get internal view offset matrix for stereo render (selected eye)
		[CLink]
		public static extern void rlSetMatrixProjection(Matrix proj);                            // Set a custom projection matrix (replaces internal projection matrix)
		[CLink]
		public static extern void rlSetMatrixModelview(Matrix view);                             // Set a custom modelview matrix (replaces internal modelview matrix)
		[CLink]
		public static extern void rlSetMatrixProjectionStereo(Matrix right, Matrix left);        // Set eyes projection matrices for stereo rendering
		[CLink]
		public static extern void rlSetMatrixViewOffsetStereo(Matrix right, Matrix left);        // Set eyes view offsets matrices for stereo rendering

		// Quick and dirty cube/quad buffers load->draw->unload
		[CLink]
		public static extern void rlLoadDrawCube();     // Load and draw a cube
		[CLink]
		public static extern void rlLoadDrawQuad();     // Load and draw a quad
	}
}
