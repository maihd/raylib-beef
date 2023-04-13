using System;

namespace Raylib
{
	[CRepr]
	public struct Transform
	{
		public Vector3 translation;// Translation
		public Vector4 rotation;// Rotation
		public Vector3 scale;// Scale
	}
}
