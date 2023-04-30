/*******************************************************************************************
*
*   raylib [core] example - Basic window (adapted for HTML5 platform)
*
*   This example is prepared to compile for PLATFORM_WEB, PLATFORM_DESKTOP and PLATFORM_RPI
*   As you will notice, code structure is slightly diferent to the other examples...
*   To compile it for PLATFORM_WEB just uncomment #define PLATFORM_WEB at beginning
*
*   This example has been created using raylib 1.3 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Copyright (c) 2015 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

namespace Raylib.Examples.Core.BasicWindowWeb;

using System;

public static class Program
{
#if BF_PLATFORM_WASM
	public function void em_callback_func();

	[CLink, CallingConvention(.Stdcall)]
	public static extern void emscripten_set_main_loop(em_callback_func func, int32 fps, int32 simulateInfinteLoop);
#endif

	//----------------------------------------------------------------------------------
	// Global Variables Definition
	//----------------------------------------------------------------------------------
	const int screenWidth = 800;
	const int screenHeight = 450;

	//----------------------------------------------------------------------------------
	// Module Functions Declaration
	//----------------------------------------------------------------------------------
	//static void UpdateDrawFrame();     // Update and Draw one frame

	//----------------------------------------------------------------------------------
	// Main Enry Point
	//----------------------------------------------------------------------------------
	public static void Main()
	{
	    // Initialization
	    //--------------------------------------------------------------------------------------
	    InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");

#if BF_PLATFORM_WASM
	    emscripten_set_main_loop(=> UpdateDrawFrame, 0, 1);
#else
	    SetTargetFPS(60);   // Set our game to run at 60 frames-per-second
	    //--------------------------------------------------------------------------------------
	    
	    // Main game loop
	    while (!WindowShouldClose())    // Detect window close button or ESC key
	    {
	        UpdateDrawFrame();
	    }
#endif

	    // De-Initialization
	    //--------------------------------------------------------------------------------------
	    CloseWindow();        // Close window and OpenGL context
	    //--------------------------------------------------------------------------------------
	}

	//----------------------------------------------------------------------------------
	// Module Functions Definition
	//----------------------------------------------------------------------------------
	public static void UpdateDrawFrame()
	{
	    // Update
	    //----------------------------------------------------------------------------------
	    // TODO: Update your variables here
	    //----------------------------------------------------------------------------------

	    // Draw
	    //----------------------------------------------------------------------------------
	    BeginDrawing();

	        ClearBackground(.RAYWHITE);

	        DrawText("Congrats! You created your first window!", 190, 200, 20, .LIGHTGRAY);

	    EndDrawing();
	    //----------------------------------------------------------------------------------
	}
}