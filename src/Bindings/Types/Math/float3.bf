using System;

namespace Raylib
{
	// NOTE: Helper types to be used instead of array return types for *ToFloat functions
	[CRepr]
	public struct float3
	{
		public float[3] v;
	}
}
