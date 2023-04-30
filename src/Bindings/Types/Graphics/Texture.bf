using System;

namespace Raylib
{
	// Texture2D, same as Texture
	typealias Texture2D = Texture;
	
	// TextureCubemap, same as Texture
	typealias TextureCubemap = Texture;
	
	// Texture, tex data stored in GPU memory (VRAM)
	[CRepr]
	public struct Texture
	{
		public uint32 		id;			// OpenGL texture id
		public int32 		width;		// Texture base width
		public int32 		height;		// Texture base height
		public int32 		mipmaps;	// Mipmap levels, 1 by default
		public PixelFormat 	format;		// Data format (PixelFormat type)
	}
}
