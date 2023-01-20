using System;
using System.Interop;
using System.Diagnostics;

using Raylib.Enums;
using Raylib.Types;

namespace Raylib
{
	static
	{
		public const char8* RAYLIB_VERSION = "4.2.0";

		public const float DEG2RAD = Math.PI_f / 180.0f;
		public const float RAD2DEG = 180.0f / Math.PI_f;

		public const int MAX_SHADER_LOCATIONS = 32;
		public const int MAX_MATERIAL_MAPS = 12;
		public const int MAX_TOUCH_POINTS = 10;
	}

	public static class Functions
	{
	}

	public abstract class RaylibApp
	{
		private static Self gApp;

		public String 	Title;
		public int32	Width;
		public int32	Height;

		public this()
		{
			Debug.Assert(gApp == null, "Multiple application created");
			gApp = this;
		}

		public virtual void Init()
		{
			Functions.InitWindow(Width, Height, Title.CStr());
			Functions.InitAudioDevice();
		}

		public virtual void Close()
		{
			Functions.CloseAudioDevice();
			Functions.CloseWindow();
		}

		public virtual void Update(float dt)
		{
		}

		public virtual void Draw()
		{
		}

		public virtual void Run()
		{
			Init();

#if BF_PLATFORM_WASM
			defer Close();
			emscripten_set_main_loop(=> EmscriptenMainLoop, 0, 1);
#else
			while (RunOneFrame()) {}
#endif
		}

		private bool RunOneFrame()
		{
			if (!Functions.WindowShouldClose())
			{
				Update(Functions.GetFrameTime());

				Functions.BeginDrawing();
				Draw();
				Functions.EndDrawing();

				return true;
			}

			return false;
		}

#if BF_PLATFORM_WASM
			private function void em_callback_func();

			[CLink, CallingConvention(.Stdcall)]
			private static extern void emscripten_set_main_loop(em_callback_func func, int32 fps, int32 simulateInfinteLoop);

			[CLink, CallingConvention(.Stdcall)]
			private static extern int32 emscripten_set_main_loop_timing(int32 mode, int32 value);

			[CLink, CallingConvention(.Stdcall)]
			private static extern double emscripten_get_now();

			private static void EmscriptenMainLoop()
			{
				gApp.RunOneFrame();
			}
#endif
	}
}
