using System;

namespace Raylib
{
	// NOTE: Helper types to be used instead of array return types for *ToFloat functions
	[CRepr]
	public struct float16
	{
		public float[16] v;
	}
}
