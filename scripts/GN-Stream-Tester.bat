@echo off
chcp 65001 > nul

:menu
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN STREAM TESTER v1.0                 *
echo      * Test online radio and video streams     *
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

echo.
set /p "stream_url=--> Enter or paste the stream URL and press Enter: "

if "%stream_url%"=="" (
    echo No URL entered.
    pause
    goto menu
)

echo.
echo   Attempting to connect to the stream...
echo   URL: %stream_url%
echo.

ffplay.exe -window_title "GN Stream Tester" "%stream_url%"

echo.
echo   Playback finished or failed.
pause
goto menu