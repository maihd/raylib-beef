@echo off

: Get raylib source code

git clone https://github.com/raysan5/raylib --depth 1 --branch 4.5.0 deps/raylib

: Build raylib for Web

pushd deps\raylib\src

call emcc -c rcore.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
call emcc -c rshapes.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
call emcc -c rtextures.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
call emcc -c rtext.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
call emcc -c rmodels.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
call emcc -c utils.c -Os -Wall -DPLATFORM_WEB
call emcc -c raudio.c -Os -Wall -DPLATFORM_WEB

call emar rcs libraylib.a rcore.o rshapes.o rtextures.o rtext.o rmodels.o utils.o raudio.o

popd

: Copy files to dist folder

if not exist dist (
    mkdir dist
)

if not exist dist\wasm32 (
    mkdir dist\wasm32
)

copy .\deps\raylib\LICENSE .\dist\LICENSE
copy .\deps\raylib\src\libraylib.a .\dist\wasm32\libraylib.a