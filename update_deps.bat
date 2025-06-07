@echo off

: Remove old deps
rmdir deps /Q /S

: Get raylib source code
if not exist deps\raylib (
    git clone https://github.com/raysan5/raylib --depth 1 --branch 5.5 deps/raylib
)