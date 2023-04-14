using System;

namespace Raylib
{
	// Rectangle, 4 components
	[CRepr]
	public struct Rectangle
	{
		public float x;			// Rectangle top-left corner position x
		public float y;			// Rectangle top-left corner position y
		public float width;		// Rectangle width
		public float height;	// Rectangle height
	}
}
