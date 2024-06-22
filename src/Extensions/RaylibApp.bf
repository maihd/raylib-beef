namespace Raylib;

using System;
using System.Diagnostics;

public abstract class RaylibApp
{
	private static Self gApp;

	public String 		title;
	public int32		width;
	public int32		height;
	public ConfigFlags	config;
	public int32		fps = 60;

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

	private void InternalInit()
	{
		InitWindow(width, height, title.CStr());
		InitAudioDevice();
		SetTargetFPS(fps);

		if (config != 0)
		{
			SetConfigFlags(config);
		}

		Init();
	}

	private void InternalClose()
	{
		Close();

		CloseAudioDevice();
		CloseWindow();
	}

	public virtual void Run()
	{
		InternalInit();

#if BF_PLATFORM_WASM
		emscripten_set_main_loop(=> EmscriptenMainLoop, fps, 1);
#else
		defer InternalClose();
		while (RunOneFrame()) {}
#endif
	}

	private bool RunOneFrame()
	{
		if (!WindowShouldClose())
		{
			// @todo: add pre-frame/post-frame events

			// @todo: make this per-step update
			Update(GetFrameTime());

			// @todo: add fixed-deltaTime update

			BeginDrawing();
			{
				Draw();
			}
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

#region callbacks

	protected virtual void Init() {}
	protected virtual void Close() {}

	protected virtual void Update(float dt) {}
	protected virtual void Draw() {}

#endregion
}