@echo off

git clone https://github.com/raysan5/raylib --depth 1 --branch 4.5.0 deps/raylib

if not defined CMAKE (
    set CMAKE=cmake
)

set RAYLIB_FLAGS=-DPLATFORM=Desktop -DOPENGL_VERSION=3.3 -DSHARED=1 -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF -DBUILD_GAMES=OFF

if not exist deps_build_x32 (
    mkdir deps_build_x32
)

pushd deps_build_x32

%CMAKE% ../deps/raylib -A Win32 -DCUSTOMIZE_BUILD=ON %RAYLIB_FLAGS% 
%CMAKE% --build . --target raylib --config Release -- /nologo /maxcpucount

popd

if not exist deps_build_x64 (
    mkdir deps_build_x64
)

pushd deps_build_x64

%CMAKE% ../deps/raylib -A x64 -DCUSTOMIZE_BUILD=ON %RAYLIB_FLAGS%
%CMAKE% --build . --target raylib --config Release -- /nologo /maxcpucount

popd

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

copy .\deps_build_x32\raylib\Release\raylib.lib .\dist\win32\raylib.lib
copy .\deps_build_x32\raylib\Release\raylib.dll .\dist\win32\raylib.dll

copy .\deps_build_x64\raylib\Release\raylib.lib .\dist\win64\raylib.lib
copy .\deps_build_x64\raylib\Release\raylib.dll .\dist\win64\raylib.dll