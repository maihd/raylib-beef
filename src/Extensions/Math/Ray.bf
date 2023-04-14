using System;

namespace Raylib
{
	public extension Ray
	{
		[Inline]
		public this()
		{
			this = default;
		}

		[Inline]
		public this(Vector3 position, Vector3 direction)
		{
			this.position = position;
			this.direction = direction;
		}
	}
}
