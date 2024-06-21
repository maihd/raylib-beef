@echo off

: Get raylib source code
if not exist deps\raylib (
    git clone https://github.com/raysan5/raylib --depth 1 --branch 5.0 deps/raylib
)

: CMake variables

if not defined MAKE (
    set MAKE=make
)

if not defined ANDROID_NDK (
    set ANDROID_NDK=C:\Android\ndk\21.4.7075529
)

pushd deps\raylib\src

%MAKE% PLATFORM=PLATFORM_ANDROID ANDROID_ARCH=arm

rename libraylib.a libraylib_arm.a

%MAKE% PLATFORM=PLATFORM_ANDROID ANDROID_ARCH=arm64

rename libraylib.a libraylib_arm64.a

popd

: Copy files to dist folder

if not exist dist (
    mkdir dist
)

if not exist dist\android_arm (
    mkdir dist\android_arm
)

if not exist dist\android_arm64 (
    mkdir dist\android_arm64
)

copy .\deps\raylib\LICENSE .\dist\LICENSE

copy .\deps\raylib\src\libraylib_arm.a .\dist\android_arm\libraylib.a
copy .\deps\raylib\src\libraylib_arm64.a .\dist\android_arm64\libraylib.a