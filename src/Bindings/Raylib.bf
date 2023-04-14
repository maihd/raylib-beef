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

	public abstract class RaylibApp
	{
		private static Self gApp;

		public String 	title;
		public int32	width;
		public int32	height;
		public int32	fps = 60;

		public this()
		{
			Debug.Assert(gApp == null, "Multiple applications are existing!");
			gApp = this;
		}

		public ~this()
		{
			Debug.Assert(gApp == this, "Multiple applications are existing!");
			gApp = null;
		}

		public virtual void Init()
		{
			InitWindow(width, height, title.CStr());
			InitAudioDevice();
			SetTargetFPS(fps);
		}

		public virtual void Close()
		{
			CloseAudioDevice();
			CloseWindow();
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
			emscripten_set_main_loop(=> EmscriptenMainLoop, FPS, 1);
#else
			defer Close();
			while (RunOneFrame()) {}
#endif
		}

		private bool RunOneFrame()
		{
			if (!WindowShouldClose())
			{
				Update(GetFrameTime());

				BeginDrawing();
				Draw();
				EndDrawing();

				return true;
			}

			return false;
		}

#if BF_PLATFORM_WASM
		private function void em_callback_func();

		[CLink, CallingConvention(.Stdcall)]
		private static extern void emscripten_set_main_loop(em_callback_func func, int32 fps, int32 simulateInfinteLoop);

		private static void EmscriptenMainLoop()
		{
			gApp.RunOneFrame();
		}
#endif
	}
}
