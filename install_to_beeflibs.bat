@echo off

set BEEFLANG_PATH=C:\Program Files\BeefLang
set BEEFLIBS_PATH=%BEEFLANG_PATH%\BeefLibs

if not exist "%BEEFLANG_PATH%" (
    echo Beef not found, please sure you have installed Beef, or change BEEFLANG_PATH above
    goto :end
)

if not exist "%BEEFLIBS_PATH%" (
    echo BeefLibs not found, please sure you have installed Beef, or change BEEFLANG_PATH above
    goto :end
)

@REM if exist "%BEEFLIBS_PATH%\raylib" (
@REM     echo Raylib have been add to BeefLibs
@REM     set /p OVERWRITE = "Do you want to overwrite it? (y/n): "

@REM     if %OVERWRITE% == "y" (
@REM         echo Overwriting Raylib
@REM         rmdir /s /q Raylib
@REM         goto :copy_to_beeflibs
@REM     ) else (
@REM         echo Not overwriting Raylib
@REM         goto :end
@REM     )
@REM )

:copy_to_beeflibs
echo Copying Raylib to BeefLibs

xcopy /e /i /y .\src "%BEEFLIBS_PATH%\raylib\src"
xcopy /e /i /y .\dist "%BEEFLIBS_PATH%\raylib\dist"
copy /y .\BeefProj.toml "%BEEFLIBS_PATH%\raylib"

:end
echo Done