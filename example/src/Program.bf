namespace raylib_beef_example;

using Raylib;
using static Raylib.Functions;

class Program : RaylibApp
{
	public static void Main()
	{
		Self app = scope .();

 		app.Title = "Raylib Beef Example";
		app.Width = 800;
		app.Height = 600;
		app.Run();
	}

	public override void Draw()
	{
		ClearBackground(.(52, 52, 52, 255));

		let text = "Hello from Beef! Hope you have a good day!";
		DrawText(text, 100, 100, 20, .RAYWHITE);
	}
}