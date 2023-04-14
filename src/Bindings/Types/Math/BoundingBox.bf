using System;

namespace Raylib
{
	// BoundingBox
	[CRepr]
	public struct BoundingBox
	{
		public Vector3 min;	// Minimum vertex box-corner
		public Vector3 max;	// Maximum vertex box-corner
	}
}
