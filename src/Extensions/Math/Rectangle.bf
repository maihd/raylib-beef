using System;

namespace Raylib
{
	public extension Rectangle
	{
		[Inline]
		public Vector2 position => .(x, y);

		[Inline]
		public Vector2 size => .(width, height);

		[Inline]
		public this()
		{
			this = default;
		}
		
		[Inline]
		public this(float x, float y, float width, float height)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}

		[Inline]
		public this(Vector2 position, Vector2 size)
		{
			this.x = position.x;
			this.y = position.y;
			this.width = size.x;
			this.height = size.y;
		}

		[Inline]
		public bool Contains(Vector2 point)
		{
			return CheckCollisionPointRec(point, this);
		}
	}
}
