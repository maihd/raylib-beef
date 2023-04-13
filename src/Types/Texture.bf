using System;
using Raylib.Enums;

namespace Raylib
{
	typealias Texture2D = Texture;

	typealias TextureCubemap = Texture;

	[CRepr]
	public struct Texture
	{
		/// OpenGL texture id
		public uint32 id;
		/// Texture base width
		public int32 width;
		/// Texture base height
		public int32 height;
		/// Mipmap levels, 1 by default
		public int32 mipmaps;
		/// Data format (PixelFormat type)
		public uint32 format;

	}
}
