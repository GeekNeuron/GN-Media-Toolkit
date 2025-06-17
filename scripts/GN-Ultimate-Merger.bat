@echo off
chcp 65001 > nul

:: ##################################################################
:: # GN Ultimate Merger v2.0                                      #
:: # Interactive Audio/Video/Subtitle Merger with Advanced Options  #
:: ##################################################################

:header
cls
echo.
echo      **********************************************************
echo      * *
echo      * GN ULTIMATE MERGER v2.0                 *
echo      * *
echo      * Advanced merging for Video, Audio, Subs & More!     *
echo      * *
echo      **********************************************************
echo.

:: --- Dependency Check ---
ffmpeg -version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] FFmpeg not found! Please place ffmpeg.exe in the same folder.
    pause
    exit /b
)

:: --- User Inputs ---
echo --- Step 1: Base Files ---
set /p "videoFile=--> Drag & Drop VIDEO file: "
set /p "audioFile=--> Drag & Drop PRIMARY AUDIO file: "

echo.
echo --- Step 2: Optional Tracks (Press Enter to skip) ---
set /p "audioFile2=--> Drag & Drop SECOND AUDIO file (optional): "
set /p "subFile=--> Drag & Drop SUBTITLE file (optional): "
set /p "coverFile=--> Drag & Drop COVER ART image (optional): "

echo.
echo --- Step 3: Metadata & Output ---
set /p "fileTitle=--> Enter a Title for the file: "
set /p "format=--> Output format (MKV/MP4) [Default: MKV]: "
if /i "%format%"=="" set "format=mkv"
if /i "%format%"=="mp4" set "format=mp4"

echo.
echo --- Step 4: Trimming (Optional) ---
echo    (Example format: 00:01:23 for 1 minute 23 seconds)
set /p "startTime=--> Start time (HH:MM:SS) (optional): "
set "endTime="
if defined startTime (
    set /p "endTime=--> End time (HH:MM:SS) (required): "
)

echo.
echo --- Step 5: Output Path ---
set /p "outputPath=--> Output path (or press Enter for Desktop): "
if "%outputPath%"=="" set "outputPath=%USERPROFILE%\Desktop"
if not exist "%outputPath%" mkdir "%outputPath%"

:: --- Build FFmpeg Command Dynamically ---
set "ffmpeg_cmd=ffmpeg -hide_banner -loglevel error -stats"

:: Add trimming options if defined
if defined startTime (
    set "ffmpeg_cmd=%ffmpeg_cmd% -ss %startTime% -to %endTime%"
)

:: Add inputs
set "ffmpeg_cmd=%ffmpeg_cmd% -i %videoFile% -i %audioFile%"
set "map_cmd=-map 0:v:0 -map 1:a:0"
set "stream_counter=1"

if exist %audioFile2% (
    set /a stream_counter+=1
    set "ffmpeg_cmd=%ffmpeg_cmd% -i %audioFile2%"
    set "map_cmd=%map_cmd% -map %stream_counter%:a:0"
)
if exist %subFile% (
    set /a stream_counter+=1
    set "ffmpeg_cmd=%ffmpeg_cmd% -i %subFile%"
    set "map_cmd=%map_cmd% -map %stream_counter%:s:0"
)
if exist %coverFile% (
    set /a stream_counter+=1
    set "ffmpeg_cmd=%ffmpeg_cmd% -i %coverFile%"
    set "map_cmd=%map_cmd% -map %stream_counter%:v:0"
    set "disposition_cmd=-disposition:%stream_counter% attached_pic"
)

:: Set codecs
set "codec_cmd=-c:v copy -c:a copy"
if exist %subFile% (
    if /i "%format%"=="mp4" (
        set "codec_cmd=%codec_cmd% -c:s mov_text"
    ) else (
        set "codec_cmd=%codec_cmd% -c:s copy"
    )
)

:: Set metadata
set "metadata_cmd=-metadata title="%fileTitle%" -metadata comment="Merged with GN Ultimate Merger""

:: Define output file and log file
set "outputFile=%outputPath%\%~n1 - Ultimate.%format%"
set "logFile=%outputPath%\GN-Merger-Log.txt"

:: --- Execute Command ---
echo.
echo =========================================================
echo.
echo   Starting process... Please wait.
echo   A log file will be created at: %logFile%
echo.
echo =========================================================

%ffmpeg_cmd% %map_cmd% %codec_cmd% %disposition_cmd% %metadata_cmd% "%outputFile%" >> "%logFile%" 2>&1

if %errorlevel% neq 0 (
    echo [ERROR] Merging failed! Check "%logFile%" for details.
) else (
    echo   SUCCESS! File saved to:
    echo   %outputFile%
)
echo.
echo =========================================================
pause