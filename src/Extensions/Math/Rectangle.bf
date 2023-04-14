using System;

namespace Raylib
{
	public extension Rectangle
	{
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
	}
}
