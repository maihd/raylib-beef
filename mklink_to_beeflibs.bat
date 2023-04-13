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

if exist "%BEEFLIBS_PATH%\raylib" (
    echo Overwriting "%BEEFLIBS_PATH%\raylib"
    rmdir /s /q "%BEEFLIBS_PATH%\raylib"
    del "%BEEFLIBS_PATH%\raylib"
)

mklink /J "%BEEFLIBS_PATH%\raylib" .

:end
echo Done