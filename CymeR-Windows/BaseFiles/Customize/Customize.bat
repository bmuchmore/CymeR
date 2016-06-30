@echo off
set current=%cd%
pushd ..
set parent=%cd%
pushd ..
set grandparent=%cd%
popd
C:\Users\%USERNAME%\.babun\cygwin\bin\bash.exe -l %~dp0\Customize.sh
PAUSE