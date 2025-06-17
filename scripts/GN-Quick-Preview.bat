@echo off
chcp 65001 > nul

:: ###############################################################
:: # GN Quick Preview v1.0                                       #
:: # Simple, borderless, auto-exit media player.                 #
:: # Usage: Drag & drop a media file onto this script.           #
:: ###############################################################

cls
echo.
echo      *******************************************************
echo      * *
echo      * GN QUICK PREVIEW v1.0                 *
echo      * *
echo      *******************************************************
echo.

:: --- Dependency Check ---
ffplay -version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] ffplay.exe not found! Please place it in the same folder.
    pause
    exit /b
)

if "%~1"=="" (
    echo Please drag and drop a media file onto this script icon to play it.
    pause
    exit /b
)

echo Playing: %~nx1
ffplay.exe -autoexit -noborder -window_title "GN Preview: %~nx1" %1