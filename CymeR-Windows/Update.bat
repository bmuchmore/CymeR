@echo off
copy %~dp0\BaseFiles\Update\Dockerfile C:\Users\%USERNAME%\.babun\cygwin\home\%USERNAME%\Dockerfile
C:\Users\%USERNAME%\.babun\cygwin\bin\bash.exe -l %~dp0\BaseFiles\Update\update.sh
