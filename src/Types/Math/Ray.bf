using System;

namespace Raylib
{
	// Ray, ray for raycasting
	[CRepr]
	public struct Ray
	{
		public Vector3 position;	// Ray position (origin)
		public Vector3 direction;	// Ray direction

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
