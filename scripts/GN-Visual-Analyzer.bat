@echo off
chcp 65001 > nul

:menu
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN VISUAL ANALYZER v1.0               *
echo      * Waveform | Spectrum                   *
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

set "inputFile="
set /p "inputFile=--> Drag & Drop your media file: "
if not exist %inputFile% (
    echo [ERROR] File not found.
    pause
    goto menu
)

:analysis_choice
cls
echo   Selected file: %~nx1
echo.
echo   How would you like to analyze it?
echo.
echo      1. Normal Playback
echo      2. Show Audio Waveform (visualizes sound waves)
echo      3. Show Audio Spectrum (visualizes frequencies)
echo      4. Go Back to Main Menu
echo.
set /p "choice=--> Enter your choice (1-4): "
if "%choice%"=="1" set "mode_cmd="
if "%choice%"=="2" set "mode_cmd=-showmode 1"
if "%choice%"=="3" set "mode_cmd=-showmode 2"
if "%choice%"=="4" goto menu
if not defined mode_cmd goto analysis_choice

echo.
echo   Starting playback...
echo   (You can close the player window to return here)
echo.

ffplay.exe %mode_cmd% %inputFile%

goto menu