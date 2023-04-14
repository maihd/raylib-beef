using System;
using System.Interop;
using System.Diagnostics;

namespace Raylib
{
	static
	{
		public const char8* RLGL_VERSION = "4.5";
		public const char8* RAYLIB_VERSION = "4.5.0";

		public const float DEG2RAD = Math.PI_f / 180.0f;
		public const float RAD2DEG = 180.0f / Math.PI_f;

		public const int MAX_SHADER_LOCATIONS = 32;
		public const int MAX_MATERIAL_MAPS = 12;
		public const int MAX_TOUCH_POINTS = 10;
	}
}
