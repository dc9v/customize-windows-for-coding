@echo off

set "params=%*"
cd /d "%~dp0"
if exist "%temp%\setUAC.vbs" del "%temp%\setUAC.vbs"
fsutil dirty query %systemdrive% 1>nul 2>nul || (echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\setUAC.vbs" && "%temp%\setUAC.vbs" && exit /B )

setlocal enabledelayedexpansion
set "hex=0123456789ABCDEF"
set /p INPUT=Enter Brightness (0-100):
set /a high=%INPUT% / 16
set /a low=%INPUT% %% 16

echo Windows Registry Editor Version 5.00 > windows-surface-brightness-controll-service.reg

echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Surface\Surface Brightness Control] >> windows-surface-brightness-controll-service.reg
echo "FullBrightness"=dword:000000!hex:~%high%,1!!hex:~%low%,1! >> windows-surface-brightness-controll-service.reg


net stop SurfaceBrightnessService

regedit.exe /S windows-surface-brightness-controll-service.reg

net start SurfaceBrightnessService

del windows-surface-brightness-controll-service.reg

exit