@echo off
chcp 65001 > nul

:menu
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN QUICK FIX v1.0                     *
echo      * Rotate & Watermark                    *
echo      * *
echo      *******************************************************
echo.
echo   What would you like to do?
echo.
echo      1. Rotate a Video
echo      2. Add a Watermark to Video
echo      3. Exit
echo.
set /p "choice=--> Enter your choice (1-3): "
if "%choice%"=="1" goto rotateVideo
if "%choice%"=="2" goto addWatermark
if "%choice%"=="3" exit /b
goto menu

:: --- ROTATE VIDEO ---
:rotateVideo
cls
echo --- Rotating Video ---
echo.
set /p "inputFile=--> Drag & Drop your VIDEO file: "
echo.
echo   How to rotate?
echo      1. 90 degrees Clockwise (Right)
echo      2. 90 degrees Counter-Clockwise (Left)
echo      3. 180 degrees (Flip Upside Down)
set /p "rot_choice=--> Enter your choice (1-3): "
if "%rot_choice%"=="1" set "transpose_cmd=transpose=1"
if "%rot_choice%"=="2" set "transpose_cmd=transpose=2"
if "%rot_choice%"=="3" set "transpose_cmd=transpose=2,transpose=2"
set "outputFile=%~dpn1 - Rotated.mp4"

echo.
echo Rotating video... This may take a while as it needs re-encoding.
ffmpeg -hide_banner -loglevel error -i %inputFile% -vf "%transpose_cmd%" "%outputFile%"
echo.
echo SUCCESS! Rotated video saved to: %outputFile%
pause
goto menu

:: --- ADD WATERMARK ---
:addWatermark
cls
echo --- Adding a Watermark ---
echo.
set /p "inputFile=--> Drag & Drop your VIDEO file: "
set /p "watermarkFile=--> Drag & Drop your WATERMARK image (PNG): "
echo.
echo   Where to place the watermark?
echo      1. Top-Right
echo      2. Top-Left
echo      3. Bottom-Right
echo      4. Bottom-Left
set /p "pos_choice=--> Enter your choice (1-4) [Default: 1]: "
if "%pos_choice%"=="1" set "overlay_cmd=overlay=W-w-10:10"
if "%pos_choice%"=="2" set "overlay_cmd=overlay=10:10"
if "%pos_choice%"=="3" set "overlay_cmd=overlay=W-w-10:H-h-10"
if "%pos_choice%"=="4" set "overlay_cmd=overlay=10:H-h-10"
if not defined overlay_cmd set "overlay_cmd=overlay=W-w-10:10"
set "outputFile=%~dpn1 - Watermarked.mp4"

echo.
echo Adding watermark... This may take a while as it needs re-encoding.
ffmpeg -hide_banner -loglevel error -i %inputFile% -i %watermarkFile% -filter_complex "%overlay_cmd%" "%outputFile%"
echo.
echo SUCCESS! Watermarked video saved to: %outputFile%
pause
goto menu