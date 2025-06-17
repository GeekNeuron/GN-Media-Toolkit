@echo off
chcp 65001 > nul

:menu
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN EXTRACTOR v1.0                     *
echo      * Audio | Screenshot | GIF                *
echo      * *
echo      *******************************************************
echo.
echo   What would you like to extract?
echo.
echo      1. Extract Audio from Video
echo      2. Take a Screenshot from Video
echo      3. Create a high-quality GIF from Video
echo      4. Exit
echo.
set /p "choice=--> Enter your choice (1-4): "
if "%choice%"=="1" goto extractAudio
if "%choice%"=="2" goto extractScreenshot
if "%choice%"=="3" goto createGif
if "%choice%"=="4" exit /b
goto menu

:: --- AUDIO EXTRACTION ---
:extractAudio
cls
echo --- Extracting Audio (without quality loss) ---
echo.
set /p "inputFile=--> Drag & Drop your VIDEO file: "
set /p "format=--> Choose audio format (aac, mp3) [Default: aac]: "
if "%format%"=="" set "format=aac"
set "outputFile=%~dpn1 - Extracted.%format%"
echo.
echo Starting extraction...
ffmpeg -hide_banner -loglevel error -i %inputFile% -vn -c:a copy "%outputFile%"
echo.
echo SUCCESS! Audio saved to: %outputFile%
pause
goto menu

:: --- SCREENSHOT EXTRACTION ---
:extractScreenshot
cls
echo --- Taking a Screenshot ---
echo.
set /p "inputFile=--> Drag & Drop your VIDEO file: "
set /p "timestamp=--> Enter the exact time (e.g., 00:01:23.456): "
set "outputFile=%~dpn1 - Screenshot at %timestamp_safe%.png"
set "outputFile=%outputFile::=%"
set "outputFile=%outputFile:.=%"

echo.
echo Taking screenshot...
ffmpeg -hide_banner -loglevel error -ss %timestamp% -i %inputFile% -vframes 1 "%outputFile%"
echo.
echo SUCCESS! Screenshot saved to: %outputFile%
pause
goto menu

:: --- GIF CREATION ---
:createGif
cls
echo --- Creating a High-Quality GIF ---
echo.
set /p "inputFile=--> Drag & Drop your VIDEO file: "
set /p "startTime=--> Enter start time (e.g., 00:00:10): "
set /p "duration=--> Enter duration in seconds (e.g., 3): "
set /p "width=--> Enter width in pixels (e.g., 540) [Default: 540]: "
if "%width%"=="" set "width%=540"
set "palette=%TEMP%\palette.png"
set "outputFile=%~dpn1.gif"

echo.
echo Step 1 of 2: Analyzing color palette...
ffmpeg -hide_banner -loglevel error -ss %startTime% -t %duration% -i %inputFile% -vf "fps=15,scale=%width%:-1:flags=lanczos,palettegen" -y "%palette%"

echo Step 2 of 2: Creating GIF...
ffmpeg -hide_banner -loglevel error -ss %startTime% -t %duration% -i %inputFile% -i "%palette%" -filter_complex "fps=15,scale=%width%:-1:flags=lanczos[x];[x][1:v]paletteuse" -y "%outputFile%"
echo.
echo SUCCESS! GIF saved to: %outputFile%
pause
goto menu