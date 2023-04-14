using System;

namespace Raylib
{
	// N-patch layout
	public enum NPatchLayout : int32
	{
		NPATCH_NINE_PATCH = 0,           // Npatch layout: 3x3 tiles
		NPATCH_THREE_PATCH_VERTICAL,     // Npatch layout: 1x3 tiles
		NPATCH_THREE_PATCH_HORIZONTAL    // Npatch layout: 3x1 tiles
	}
}
