@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

cls
echo.
echo      *******************************************************
echo      * *
echo      * GN SCENE CREATOR v1.0                   *
echo      * Cinematic Video Storyboard Generator    *
echo      * *
echo      *******************************************************
echo.

:: --- Prerequisite Check ---
ffmpeg -version > nul 2>&1
if %errorlevel% neq 0 (echo [ERROR] ffmpeg.exe not found! & pause & exit /b)
magick -version > nul 2>&1
if %errorlevel% neq 0 (echo [ERROR] ImageMagick not found! Please install it and ensure it's in your PATH. & pause & exit /b)

set /p "inputFile=--> Drag & Drop your VIDEO file: "
if not exist %inputFile% (echo [ERROR] File not found. & pause & exit /b)

set "temp_folder=_Scenes_%time::=.%"
mkdir "%temp_folder%"

echo.
echo [1/4] Analyzing video duration...
for /f %%a in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%inputFile%"') do (
    set /a "duration=%%a"
)

echo.
echo [2/4] Extracting 9 keyframe screenshots...
for /l %%i in (1,1,9) do (
    set /a "timestamp=%%i*duration/10"
    ffmpeg -hide_banner -ss !timestamp! -i "%inputFile%" -vframes 1 "%temp_folder%\scene_%%i.png"
)

echo.
echo [3/4] Creating cinematic montage with ImageMagick...
magick montage "%temp_folder%\scene_*.png" -tile 3x3 -geometry +5+5 -background black "%temp_folder%\montage.png"

echo.
echo [4/4] Adding title and finalizing the image...
set "title=%~n1"
magick convert "%temp_folder%\montage.png" -gravity South -pointsize 40 -fill white -stroke black -strokewidth 2 -annotate +0+10 "!title!" "%~dp1\%~n1 - Scene Card.png"

:: Cleanup
rmdir /s /q "%temp_folder%"

echo.
echo =======================================================
echo   SUCCESS!
echo   Your cinematic scene card has been created:
echo   %~dp1\%~n1 - Scene Card.png
echo =======================================================
pause