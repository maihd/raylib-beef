# Raylib-Beef

<img align="left" src="https://github.com/M0n7y5/raylib-beef/raw/master/img/raylib-beef-logo.png" width="256px">

**raylib-beef** is a Beef wrapper library and Beefie Version for **Raylib 4.2.0**, a simple and easy-to-use library. In combination with the benefits of the Beef programming language, making games is pure satisfaction!

> **Attention!** These bindings are still in development. Bugs may occur.
	You can download this library with binaries from the [Release page](https://github.com/M0n7y5/raylib-beef/releases)!

> **OS Support** is limited to Windows/Wasm32 right now. I am only able test this library on Windows/Wasm32 at the moment. Wasm32 have memory access bugs (Im experiment with other project that target with Beef + WebGL and C + Raylib + WebGL to find out what cause bugs).

> **Visual Studio** versions only worked on vs2017 and vs2019. vs2022 cause may undefined references. dist is build with Visual Studio 2019, if you face any build errors or crash on runtime, please run build_deps.bat to rebuid dist with your devenv.

<br>
<br>

---

## What is done
- Bindings for:
    - raylib.h
    - raymath.h 
    - rlgl.h (partly)
	- Easings.h

## Important notes
- there are no bindings for text manipulating methods
	- Beef already has custom methods for text manupulation
-  rlgl bindings are **partly done**
- Add `-sUSE_GLFW=3` on wasm32 target

## TODO:
- Rewrite examples in Beef
- finish rlgl.h bindings

# Quick Start *(using Beef IDE)*
1. **Download** raylib-beef.zip **FROM RELEASE PAGE** and extract raylib-beef folder from that zip file to: **C:\Program Files\BeefLang\BeefLibs**
2. Right-click on your workspace and select **Add from Installed** and choose raylib-beef

![](img/from-installed.png)

3. **Add** raylib-beef **as a dependency** of your project

![](img/add-deps.png)



4. Write some code:
```csharp
using System;
using static raylib_beef.Raylib;

namespace YOUR_NAMESPACE_HERE
{
	class Program
	{
		public static int Main(String[] args)
		{
			let text = "Hello from Beef! Hope you have a good day!";

			SetConfigFlags(.FLAG_WINDOW_RESIZABLE);
			InitWindow(800, 600, "Hello world");
			SetTargetFPS(60);

			while (!WindowShouldClose())
			{
				BeginDrawing();

				ClearBackground(.(52, 52, 52, 255));

				var x = (GetScreenWidth() / 2) - (MeasureText(text, 35) / 2);
				var y = GetScreenHeight() / 2;

				DrawText(text, x, y, 35, .LIGHTGRAY);

				EndDrawing();
			}

			CloseWindow();
			return 0;
		}
	}
}
```
5. Profit!

<center>

![](img/screen.png)

</center>

## Static linking
> Static linking is not worked now.
By default linking is set to dynamically link to Raylib. You can change that by selecting different raylib-beef **project configuration** in **Workspace** settings. You can select from **DebugStatic** and **ReleaseStatic**.

![](img/static-linking.png)

Then **set** your app project **build properties** to this:

![](img/build-settings.png)

# More Examples
https://github.com/DerTee/raylib-beef-examples

# More Info
- More info about **raylib** (https://github.com/raysan5/raylib)
- More info about **BeefLang** (https://www.beeflang.org)

# Contribution

I'll be glad for any reported issues & pull requests

## Notes
- any contributions apart from bugfixes need to be placed in `src/Extensions`
	- this will separate additional helper functions from bindings
	- for example if you want to add some cool method for **Vector3**, you will create **Vector3.&#xfeff;bf** in `src/Extensions/Types` and add that cool method to existing Vector3 type by using [extensions](https://www.beeflang.org/docs/language-guide/datatypes/extensions/) statement
