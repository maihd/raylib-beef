using System;

namespace Raylib
{
	typealias Camera = Camera3D;
	
	public extension Camera3D
	{
		public this(Vector3 position, Vector3 target, Vector3 up, float fovy = 90, CameraProjection projection = .CAMERA_PERSPECTIVE)
		{
			this.position = position;
			this.target = target;
			this.up = up;
			this.fovy = fovy;
			this.projection = projection;
		}

		public this()
		{
			this = default;
		}
	}
}
