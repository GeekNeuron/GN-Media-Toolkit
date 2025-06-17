@echo off
chcp 65001 > nul

:menu
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN SUBTITLE DOWNLOADER v1.0             *
echo      * YouTube Subtitle Finder & Downloader    *
echo      * *
echo      *******************************************************
echo.

:: --- Dependency Check ---
yt-dlp --version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] yt-dlp.exe not found! Please download it and place it
    echo         in the same folder as this script.
    pause
    exit /b
)

set "video_url="
set /p "video_url=--> Enter the YouTube video URL and press Enter: "
if not defined video_url goto menu

echo.
echo --- Step 1: Searching for available subtitles... ---
echo.

:: List all available subtitles for the URL
yt-dlp --list-subs "%video_url%"

echo.
echo --- Step 2: Choose a subtitle to download ---
echo.
echo   From the list above, enter the language code you want.
echo   (e.g., fa, en, en-US, de)
echo.
set /p "lang_code=--> Enter language code (or press Enter to cancel): "

if not defined lang_code (
    echo Canceled. Returning to main menu...
    pause
    goto menu
)

echo.
echo --- Step 3: Downloading subtitle... ---
echo.

:: Download the specific subtitle, but not the video itself
yt-dlp --write-sub --sub-langs "%lang_code%" --skip-download "%video_url%"

echo.
echo =======================================================
echo   SUCCESS!
echo   The subtitle file (.srt or .vtt) has been saved in this folder.
echo =======================================================
pause
goto menu