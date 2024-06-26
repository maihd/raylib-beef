@echo off

set ANDROID_API=33

echo Building ARM
BeefBuild -config=Debug -platform=armv7-none-linux-androideabi%ANDROID_API%
echo Building ARM64
BeefBuild -config=Debug -platform=aarch64-none-linux-android%ANDROID_API%
echo Building x86
BeefBuild -config=Debug -platform=i686-none-linux-android%ANDROID_API%
echo Building x86_64
BeefBuild -config=Debug -platform=x86_64-none-linux-android%ANDROID_API%

echo All done!
pause