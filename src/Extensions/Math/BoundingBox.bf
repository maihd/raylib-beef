using System;

namespace Raylib
{
	public extension BoundingBox
	{
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
