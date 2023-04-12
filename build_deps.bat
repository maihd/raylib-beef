@echo off

: Get raylib source code

git clone https://github.com/raysan5/raylib --depth 1 --branch 4.5.0 deps/raylib

: CMake variables

if not defined CMAKE (
    set CMAKE=cmake
)

set RAYLIB_FLAGS=-DPLATFORM=Desktop -DOPENGL_VERSION=3.3 -DBUILD_EXAMPLES=OFF
set RAYLIB_DLL_FLAGS=%RAYLIB_FLAGS% -DBUILD_SHARED_LIBS=ON -DSHARED=1

: Build raylib static library for x86

if not exist deps_build_x32 (
    mkdir deps_build_x32
)

pushd deps_build_x32

%CMAKE% ../deps/raylib -A Win32 -DCUSTOMIZE_BUILD=ON %RAYLIB_FLAGS%
%CMAKE% --build . --target raylib --config Release -- /nologo /maxcpucount

popd

: Build raylib static library for x64

if not exist deps_build_x64 (
    mkdir deps_build_x64
)

pushd deps_build_x64

%CMAKE% ../deps/raylib -A x64 -DCUSTOMIZE_BUILD=ON %RAYLIB_FLAGS%
%CMAKE% --build . --target raylib --config Release -- /nologo /maxcpucount

popd

: Build raylib DLL for x86

@REM if not exist deps_build_x32_dll (
@REM     mkdir deps_build_x32_dll
@REM )

@REM pushd deps_build_x32_dll

@REM %CMAKE% ../deps/raylib -A Win32 -DCUSTOMIZE_BUILD=ON %RAYLIB_DLL_FLAGS%
@REM %CMAKE% --build . --target raylib --config Release -- /nologo /maxcpucount

@REM popd

: Build raylib DLL for x64

@REM if not exist deps_build_x64_dll (
@REM     mkdir deps_build_x64_dll
@REM )

@REM pushd deps_build_x64_dll

@REM %CMAKE% ../deps/raylib -A x64 -DCUSTOMIZE_BUILD=ON %RAYLIB_DLL_FLAGS%
@REM %CMAKE% --build . --target raylib --config Release -- /nologo /maxcpucount

@REM popd

: Copy files to dist folder

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

@REM copy .\deps_build_x32\raylib\Release\raylib.lib .\dist\win32\raylib.lib
@REM copy .\deps_build_x64\raylib\Release\raylib.lib .\dist\win64\raylib.lib

copy .\deps_build_x32_dll\raylib\Release\raylib.lib .\dist\win32\raylib.lib
copy .\deps_build_x32_dll\raylib\Release\raylib.dll .\dist\win32\raylib.dll

copy .\deps_build_x64_dll\raylib\Release\raylib.lib .\dist\win64\raylib.lib
copy .\deps_build_x64_dll\raylib\Release\raylib.dll .\dist\win64\raylib.dll