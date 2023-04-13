using System;
using System.Interop;

namespace Raylib
{
	[CRepr]
	public struct Image
	{
		// data refers to a void *
		public void* data;// Image raw data
		public c_int width;// Image base width
		public c_int height;// Image base height
		public c_int mipmaps;// Mipmap levels, 1 by default
		public PixelFormat format;// Data format (PixelFormat type)
	}
}
