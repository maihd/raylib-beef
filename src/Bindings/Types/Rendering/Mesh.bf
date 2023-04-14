using System;
using System.Interop;

namespace Raylib
{
	// Mesh, vertex data and vao/vbo
	[CRepr]
	public struct Mesh
	{
		public int32 	vertexCount;		// Number of vertices stored in arrays
		public int32 	triangleCount;		// Number of triangles stored (indexed or not)
		
		// Vertex attributes data
		public float* 	vertices;			// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
		public float* 	texcoords;			// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
		public float* 	texcoords2;			// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
		public float* 	normals;			// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
		public float* 	tangents;			// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
		public uint8* 	colors;				// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
		public uint16* 	indices;			// Vertex indices (in case vertex data comes indexed)

		/// Animation vertex data
		public float* 	animVertices;		// Animated vertex positions (after bones transformations)
		public float* 	animNormals;		// Animated normals (after bones transformations)
		public uint32* 	boneIds;			// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
		public float* 	boneWeights;		// Vertex bone weight, up to 4 bones influence by vertex (skinning)
		
		// OpenGL identifiers
		public uint32 vaoId;				// OpenGL Vertex Array Object id
		public int32* vboId;				// OpenGL Vertex Buffer Objects id (default vertex data)
	}
}
