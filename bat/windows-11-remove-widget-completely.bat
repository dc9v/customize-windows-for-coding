@echo off

set "params=%*"
cd /d "%~dp0"
if exist "%temp%\setUAC.vbs" del "%temp%\setUAC.vbs"
fsutil dirty query %systemdrive% 1>nul 2>nul || (echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\setUAC.vbs" && "%temp%\setUAC.vbs" && exit /B )

echo y | winget uninstall "windows web experience pack"