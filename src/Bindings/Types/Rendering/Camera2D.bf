using System;

namespace Raylib
{
	// Camera2D, defines position/orientation in 2d space
	[CRepr]
	public struct Camera2D
	{
		public Vector2 	offset;		// Camera offset (displacement from target)
		public Vector2 	target;		// Camera target (rotation and zoom origin)
		public float 	rotation;	// Camera rotation in degrees
		public float 	zoom;		// Camera zoom (scaling), should be 1.0f by default
	}
}
