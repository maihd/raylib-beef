namespace RaylibApp;

using Raylib;

class Program : Raylib.RaylibApp
{
	static void Main()
	{
		let program = scope Program()
			{
				title = "RaylibApp",
				width = 800,
				height = 600,
				config = default
			};

		program.Run();
	}

	protected override void Init()
	{
		// Initialization
	}

	protected override void Close()
	{
		// De-Initialization
	}

	protected override void Update(float dt)
	{
		// Update
		//----------------------------------------------------------------------------------
		// TODO: Update your variables here
		//----------------------------------------------------------------------------------
	}

	protected override void Draw()
	{
		ClearBackground(.RAYWHITE);
		DrawText("Congrats! You created your first window!", 190, 200, 20, .LIGHTGRAY);
	}
}