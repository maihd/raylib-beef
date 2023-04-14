using System;

namespace Raylib
{
	// BoundingBox
	[CRepr]
	public struct BoundingBox
	{
		public Vector3 min;	// Minimum vertex box-corner
		public Vector3 max;	// Maximum vertex box-corner
		
		[Inline]
		public this()
		{
			this = default;
		}

		[Inline]
		public this(Vector3 min, Vector3 max)
		{
			this.min = min;
			this.max = max;
		}
	}
}
