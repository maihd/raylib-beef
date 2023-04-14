using System;

namespace Raylib
{
	typealias RenderTexture2D = RenderTexture;

	// RenderTexture, fbo for texture rendering
	[CRepr]
	public struct RenderTexture
	{
		public uint32 	id;			// OpenGL Framebuffer Object (FBO) id
		public Texture 	texture;	// Color buffer attachment texture
		public Texture 	depth;		// Depth buffer attachment texture
	}
}
