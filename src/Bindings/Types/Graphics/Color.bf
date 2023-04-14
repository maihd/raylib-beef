using System;

namespace Raylib
{
	// Color, 4 components, R8G8B8A8 (32bit)
	[CRepr]
	public struct Color
	{
		public uint8 r;		// Color red value
		public uint8 g;		// Color green value
		public uint8 b;		// Color blue value
		public uint8 a;		// Color alpha value
	}
}
