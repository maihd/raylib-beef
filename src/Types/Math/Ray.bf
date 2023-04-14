using System;

namespace Raylib
{
	// Ray, ray for raycasting
	[CRepr]
	public struct Ray
	{
		public Vector3 position;	// Ray position (origin)
		public Vector3 direction;	// Ray direction
	}
}
