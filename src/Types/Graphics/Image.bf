using System;

namespace Raylib
{
	// Image, pixel data stored in CPU memory (RAM)
	[CRepr]
	public struct Image
	{
		public void* 		data;		// Image raw data
		public int32 		width;		// Image base width
		public int32 		height;		// Image base height
		public int32 		mipmaps;	// Mipmap levels, 1 by default
		public PixelFormat 	format;		// Data format (PixelFormat type)
	}
}
