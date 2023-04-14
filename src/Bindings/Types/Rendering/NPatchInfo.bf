using System;
namespace Raylib
{
	// NPatchInfo, n-patch layout info
	[CRepr]
	public struct NPatchInfo
	{
		public Rectangle 	source;		// Region in the texture
		public int32 		left;		// left border offset
		public int32 		top;		// top border offset
		public int32 		right;		// right border offset
		public int32 		bottom;		// bottom border offset
		public int32 		layout;		// layout of the n-patch: 3x3, 1x3 or 3x1
	}
}
