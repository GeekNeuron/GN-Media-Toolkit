@echo off
chcp 65001 > nul

:: ###############################################################
:: # GN Audio Converter v1.0                                     #
:: # Simple and effective audio format converter                 #
:: ###############################################################

:header
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN AUDIO CONVERTER v1.0                 *
echo      * *
echo      *******************************************************
echo.

:: --- Dependency Check ---
ffmpeg -version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] FFmpeg not found! Please place ffmpeg.exe in the same folder.
    pause
    exit /b
)

:: --- User Input ---
set /p "inputFile=--> Drag & Drop your AUDIO file: "
if not exist %inputFile% (
    echo [ERROR] File not found. Please restart.
    pause
    goto header
)

echo.
echo --- Choose Output Format ---
set /p "format=--> Output format (mp3 / aac / ogg / flac / wav) [Default: mp3]: "
if "%format%"=="" set "format=mp3"

echo.
echo --- Choose Audio Quality/Bitrate ---
set /p "bitrate=--> Audio Bitrate (e.g., 128k, 192k, 320k) [Default: 192k]: "
if "%bitrate%"=="" set "bitrate=192k"

echo.
set /p "outputPath=--> Output path (or press Enter for Desktop): "
if "%outputPath%"=="" set "outputPath=%USERPROFILE%\Desktop"
if not exist "%outputPath%" mkdir "%outputPath%"

set "outputFile=%outputPath%\%~n1 - Converted.%format%"

echo.
echo --- Starting Conversion... ---
echo.

ffmpeg -i %inputFile% -b:a %bitrate% "%outputFile%"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Conversion failed!
    pause
) else (
    echo.
    echo   SUCCESS! File saved to:
    echo   %outputFile%
    echo.
    pause
)