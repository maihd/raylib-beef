using System;

namespace Raylib
{
	public extension Camera2D
	{
		public this(Vector2 offset, Vector2 target, float rotation, float zoom)
		{
			this.offset = offset;
			this.target = target;
			this.rotation = rotation;
			this.zoom = zoom;
		}
	}
}
