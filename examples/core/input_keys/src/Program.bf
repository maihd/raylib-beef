/*******************************************************************************************
*
*   raylib [core] example - Keyboard input
*
*   This example has been created using raylib 1.0 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Copyright (c) 2014 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

using System;
using Raylib;

namespace Raylib.Examples.Core.InputKeys
{
	class Program
	{
		static void Main()
		{
			// Initialization
			//--------------------------------------------------------------------------------------
			int32 screenWidth = 800;
			int32 screenHeight = 450;

			InitWindow(screenWidth, screenHeight, "raylib [core] example - keyboard input");

			Vector2 ballPosition = Vector2((float)screenWidth/2, (float)screenHeight/2);

			SetTargetFPS(60);       // Set target frames-per-second
			//--------------------------------------------------------------------------------------

			// Main game loop
			while (!WindowShouldClose())    // Detect window close button or ESC key
			{
			    // Update
			    //----------------------------------------------------------------------------------
			    if (IsKeyDown(.KEY_RIGHT)) ballPosition.x += 2.0f;
			    if (IsKeyDown(.KEY_LEFT)) ballPosition.x -= 2.0f;
			    if (IsKeyDown(.KEY_UP)) ballPosition.y -= 2.0f;
			    if (IsKeyDown(.KEY_DOWN)) ballPosition.y += 2.0f;
			    //----------------------------------------------------------------------------------

			    // Draw
			    //----------------------------------------------------------------------------------
			    BeginDrawing();

			        ClearBackground(.RAYWHITE);

			        DrawText("move the ball with arrow keys", 10, 10, 20, .DARKGRAY);

			        DrawCircleV(ballPosition, 50, .MAROON);

			    EndDrawing();
			    //----------------------------------------------------------------------------------
			}

			// De-Initialization
			//--------------------------------------------------------------------------------------
			CloseWindow();        // Close window and OpenGL context
			//--------------------------------------------------------------------------------------
		}
	}
}