@echo off
chcp 65001 > nul

:: ###############################################################
:: # GN Pro Compressor v1.0                                      #
:: # Professional Video & Audio Compressor and Converter         #
:: ###############################################################

:header
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN PRO COMPRESSOR v1.0                *
echo      * Professional Media Compression Tool     *
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
echo --- Step 1: Select your media file ---
set /p "inputFile=--> Drag & Drop your VIDEO or AUDIO file: "
if not exist %inputFile% (
    echo [ERROR] File not found. Please restart.
    pause
    goto header
)

:: --- Show Original File Size ---
for %%F in (%inputFile%) do set "originalSize=%%~zF"
call :formatBytes %originalSize% originalSizeFormatted

echo.
echo =======================================================
echo   Original File Size: %originalSizeFormatted%
echo =======================================================
echo.
echo --- Step 2: Choose Compression Settings ---
echo.
echo   [INFO] x265 offers better compression (smaller files) but is slower
echo          and may not be compatible with very old devices.
set /p "encoder=--> Choose Video Encoder (x265 / x264) [Default: x265]: "
if /i "%encoder%"=="" set "encoder=x265"
if /i "%encoder%"=="x264" set "encoder_lib=libx264" & set "default_crf=23"
if /i "%encoder%"=="x265" set "encoder_lib=libx265" & set "default_crf=28"

echo.
echo   [INFO] CRF determines quality. Lower value = higher quality/bigger file.
echo          Good values: x264 (18-24), x265 (22-28).
set /p "crf=--> Enter CRF value [Default: %default_crf%]: "
if "%crf%"=="" set "crf=%default_crf%"

echo.
echo   [INFO] Preset affects speed vs compression. 'medium' is balanced.
echo          'slow' gives better compression but takes more time.
set /p "preset=--> Choose a preset (fast / medium / slow) [Default: medium]: "
if "%preset%"=="" set "preset=medium"

echo.
set /p "audio_br=--> Choose Audio Bitrate (e.g., 96k, 128k, 192k) [Default: 128k]: "
if "%audio_br%"=="" set "audio_br=128k"

echo.
echo --- Step 3: Output ---
set /p "outputPath=--> Output path (or press Enter for Desktop): "
if "%outputPath%"=="" set "outputPath=%USERPROFILE%\Desktop"
if not exist "%outputPath%" mkdir "%outputPath%"

set "outputFile=%outputPath%\%~n1 - Compressed.mp4"

:: --- Final Confirmation ---
cls
echo.
echo =======================================================
echo   COMPRESSION SUMMARY
echo =======================================================
echo   Input File: %~nx1
echo   Original Size: %originalSizeFormatted%
echo.
echo   Video Encoder: %encoder%
echo   Quality (CRF): %crf%
echo   Preset (Speed): %preset%
echo   Audio Bitrate: %audio_br%
echo.
echo   Output File: %outputFile%
echo =======================================================
echo.
echo [IMPORTANT] This process can take a long time depending on
echo             your file size and settings. Please be patient.
echo.
set /p "confirm=--> Press Enter to start, or close this window to cancel."

:: --- Execute FFmpeg ---
echo.
echo --- Starting Compression... ---
echo.

ffmpeg -i %inputFile% -c:v %encoder_lib% -crf %crf% -preset %preset% -c:a aac -b:a %audio_br% "%outputFile%"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Compression failed!
    pause
    exit /b
)

:: --- Show Final Results ---
for %%F in ("%outputFile%") do set "finalSize=%%~zF"
call :formatBytes %finalSize% finalSizeFormatted

set /a "saving_percent=(originalSize-finalSize)*100/originalSize"

echo.
echo =======================================================
echo   COMPRESSION COMPLETE!
echo =======================================================
echo   Original Size : %originalSizeFormatted%
echo   Final Size    : %finalSizeFormatted%
echo   Space Saved   : %saving_percent%%%
echo =======================================================
echo.
pause
exit /b

:: --- Subroutine to format bytes ---
:formatBytes bytes_in formatted_var_out
setlocal
set "bytes=%~1"
set "suffix=Bytes"
if %bytes% geq 1024 set /a "bytes/=1024" & set "suffix=KB"
if %bytes% geq 1024 set /a "bytes/=1024" & set "suffix=MB"
if %bytes% geq 1024 set /a "bytes/=1024" & set "suffix=GB"
endlocal & set "%2=%bytes% %suffix%"
goto :eof