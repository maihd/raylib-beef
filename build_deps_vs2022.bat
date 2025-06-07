@echo off

if not exist deps\raylib (
    git clone https://github.com/raysan5/raylib --depth 1 --branch 5.5 deps/raylib
)

if not defined VISUAL_STUDIO_VERSION (
    set VISUAL_STUDIO_VERSION=2022
)

echo Check Visual Studio version
if exist "C:\Program Files (x86)\Microsoft Visual Studio\%VISUAL_STUDIO_VERSION%\Professional\Common7\IDE" (
    echo Using Visual Studio %VISUAL_STUDIO_VERSION% Professional Path
    set VISUAL_STUDIO_PATH=C:\Program Files\Microsoft Visual Studio\%VISUAL_STUDIO_VERSION%\Professional\Common7\IDE
) else (
    echo Using Visual Studio %VISUAL_STUDIO_VERSION% Community Path
    set VISUAL_STUDIO_PATH=C:\Program Files\Microsoft Visual Studio\%VISUAL_STUDIO_VERSION%\Community\Common7\IDE
)

if exist "%VISUAL_STUDIO_PATH%" (
    echo Building Raylib Release.DLL x86 in Visual Studio %VISUAL_STUDIO_VERSION%
    call "%VISUAL_STUDIO_PATH%\devenv" "deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\raylib.sln" /Project raylib /Build "Release.DLL|x86"
    echo ErrorLevel:%ERRORLEVEL%
    if %ERRORLEVEL% EQU 0 (
        echo Build Release.DLL x86 successful!
    ) else (
        echo Build Release.DLL x86 failed!
    )

    echo Building Raylib Release.DLL x64 in Visual Studio %VISUAL_STUDIO_VERSION%
    call "%VISUAL_STUDIO_PATH%\devenv" "deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\raylib.sln" /Project raylib /Build "Release.DLL|x64"
    echo ErrorLevel:%ERRORLEVEL%
    if %ERRORLEVEL% EQU 0 (
        echo Build Release.DLL x64 successful!
    ) else (
        echo Build Release.DLL x64 failed!
    )
) else (
    echo Visual Studio %VISUAL_STUDIO_VERSION% not found! Open 'deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\raylib.sln' yourself and build it with your own version (NOTE you'll need to change VISUAL_STUDIO_VERSION above to your installed version)
)

if not exist dist (
    mkdir dist
)

if not exist dist\win32 (
    mkdir dist\win32
)

if not exist dist\win64 (
    mkdir dist\win64
)

copy .\deps\raylib\LICENSE .\dist\LICENSE

copy .\deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\build\raylib\bin\Win32\Release.DLL\raylib.lib .\dist\win32\raylib.lib
copy .\deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\build\raylib\bin\Win32\Release.DLL\raylib.dll .\dist\win32\raylib.dll

copy .\deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\build\raylib\bin\x64\Release.DLL\raylib.lib .\dist\win64\raylib.lib
copy .\deps\raylib\projects\VS%VISUAL_STUDIO_VERSION%\build\raylib\bin\x64\Release.DLL\raylib.dll .\dist\win64\raylib.dll