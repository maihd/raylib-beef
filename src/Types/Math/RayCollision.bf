using System;

namespace Raylib
{
	// RayCollision, ray hit information
	[CRepr]
	public struct RayCollision
	{
		public bool 	hit;		// Did the ray hit something?
		public float 	distance;	// Distance to the nearest hit
		public Vector3 	point;		// Point of the nearest hit
		public Vector3 	normal;		// Surface normal of hit
	}
}
