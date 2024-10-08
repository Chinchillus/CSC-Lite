rem MIT License

rem Copyright (c) 2024 Chinchill

rem Permission is hereby granted, free of charge, to any person obtaining a copy
rem of this software and associated documentation files (the "Software"), to deal
rem in the Software without restriction, including without limitation the rights
rem to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
rem copies of the Software, and to permit persons to whom the Software is
rem furnished to do so, subject to the following conditions:

rem The above copyright notice and this permission notice shall be included in all
rem copies or substantial portions of the Software.

rem THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
rem IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
rem FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
rem AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
rem LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
rem OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
rem SOFTWARE.

cls
@echo off
color c
MODE 140,40
set "params=%*"
cd /d "%~dp0" && ( if exist "%Temp%\getadmin.vbs" del "%Temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul  || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%Temp%\getadmin.vbs" && "%Temp%\getadmin.vbs" && exit /B )
title CSC Lite (v1.2 "purge")
cd /
:start
echo.
echo         CCCCCCCCCCCCC    SSSSSSSSSSSSSSS          CCCCCCCCCCCCC LLLLLLLLLLL             
echo      CCC::::::::::::C  SS:::::::::::::::S      CCC::::::::::::C L:::::::::L             
echo    CC:::::::::::::::C S:::::SSSSSS::::::S    CC:::::::::::::::C L:::::::::L             
echo   C:::::CCCCCCCC::::C S:::::S     SSSSSSS   C:::::CCCCCCCC::::C LL:::::::LL             
echo  C:::::C       CCCCCC S:::::S              C:::::C       CCCCCC   L:::::L               
echo C:::::C               S:::::S             C:::::C                 L:::::L               
echo C:::::C                S::::SSSS          C:::::C                 L:::::L               
echo C:::::C                 SS::::::SSSSS     C:::::C                 L:::::L               
echo C:::::C                   SSS::::::::SS   C:::::C                 L:::::L               
echo C:::::C                      SSSSSS::::S  C:::::C                 L:::::L               
echo C:::::C                           S:::::S C:::::C                 L:::::L               
echo  C:::::C       CCCCCC             S:::::S  C:::::C       CCCCCC   L:::::L         LLLLLL
echo   C:::::CCCCCCCC::::C SSSSSSS     S:::::S   C:::::CCCCCCCC::::C LL:::::::LLLLLLLLL:::::L
echo    CC:::::::::::::::C S::::::SSSSSS:::::S    CC:::::::::::::::C L::::::::::::::::::::::L
echo      CCC::::::::::::C S:::::::::::::::SS       CCC::::::::::::C L::::::::::::::::::::::L
echo         CCCCCCCCCCCCC  SSSSSSSSSSSSSSS            CCCCCCCCCCCCC LLLLLLLLLLLLLLLLLLLLLLLL
echo.
echo Welcome, %USERNAME%!
echo.
timeout /t 1 /nobreak >nul
goto confirm_clean
:confirm_clean
echo Are you sure you want to perform a system cleanup? This will delete various temporary files.
echo Type Y to proceed, or N to cancel.
set /p choice=Your choice [Y/N]: 
if /I "%choice%"=="Y" (
    goto csc
) else if /I "%choice%"=="N" (
    echo Cleanup canceled. Exiting...
    timeout /t 2 >nul
    exit
) else (
    echo Invalid choice. Please select Y or N.
    timeout /t 2 >nul
    goto confirm_clean
)
:csc
cls
cd C:
echo Cleaning temporary files...

if exist %WinDir%\Prefetch\*.* (
    del /s /f /q %WinDir%\Prefetch\*.* 2>nul
    echo Cleaned %WinDir%\Prefetch.
) else (
    echo %WinDir%\Prefetch folder not found or already clean.
)

if exist %Temp%\*.* (
    del /s /f /q %Temp%\*.* 2>nul
    echo Cleaned %Temp%.
) else (
    echo %Temp% folder not found or already clean.
)

if exist %AppData%\Temp\*.* (
    del /s /f /q %AppData%\Temp\*.* 2>nul
    echo Cleaned %AppData%\Temp.
) else (
    echo %AppData%\Temp folder not found or already clean.
)

if exist %HomePath%\AppData\LocalLow\Temp\*.* (
    del /s /f /q %HomePath%\AppData\LocalLow\Temp\*.* 2>nul
    echo Cleaned %HomePath%\AppData\LocalLow\Temp.
) else (
    echo %HomePath%\AppData\LocalLow\Temp folder not found or already clean.
)

if not exist %WinDir%\Temp md %WinDir%\Temp
if not exist %WinDir%\Prefetch md %WinDir%\Prefetch
if not exist %Temp% md %Temp%
if not exist %AppData%\Temp md %AppData%\Temp
if not exist %HomePath%\AppData\LocalLow\Temp md %HomePath%\AppData\LocalLow\Temp

if exist %LocalAppData%\CrashDumps\*.* (
    del /s /f /q %LocalAppData%\CrashDumps\*.* 2>nul
    echo Cleaned %LocalAppData%\CrashDumps.
) else (
    echo %LocalAppData%\CrashDumps folder not found or already clean.
)

echo Restarting explorer.exe...
taskkill /F /IM explorer.exe & start explorer

exit
