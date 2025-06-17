@echo off
chcp 65001 > nul

:: ##############################################################
:: # GN Batch Processor v1.0                                    #
:: # Automatically merges all video/audio pairs in a folder.  #
:: ##############################################################

cls
echo.
echo      **************************************************
echo      * *
echo      * GN BATCH PROCESSOR                *
echo      * *
echo      * Automatic merger for same-name video & audio  *
echo      * *
echo      **************************************************
echo.

:: --- Dependency Check ---
ffmpeg -version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] FFmpeg not found! Please place ffmpeg.exe in this folder.
    pause
    exit /b
)

set "output_folder=_Merged_Output"
if not exist "%output_folder%" mkdir "%output_folder%"

echo Searching for video/audio pairs in the current folder...
echo Merged files will be saved in "%output_folder%"
echo.

setlocal enabledelayedexpansion

set "processed_count=0"
:: Loop through all common video files
for %%F in (*.mp4 *.mkv *.mov *.avi *.webm) do (
    set "video_file=%%F"
    set "base_name=%%~nF"
    set "audio_file="

    :: Check for corresponding audio file with different extensions
    if exist "!base_name!.mp3" set "audio_file=!base_name!.mp3"
    if exist "!base_name!.m4a" set "audio_file=!base_name!.m4a"
    if exist "!base_name!.aac" set "audio_file=!base_name!.aac"
    if exist "!base_name!.wav" set "audio_file=!base_name!.wav"
    if exist "!base_name!.opus" set "audio_file=!base_name!.opus"

    if defined audio_file (
        echo --------------------------------------------------
        echo [+] Pair found:
        echo    Video: !video_file!
        echo    Audio: !audio_file!
        
        echo    Merging into MKV format...
        ffmpeg -hide_banner -loglevel error -i "!video_file!" -i "!audio_file!" -c copy "%output_folder%\!base_name!.mkv"
        
        if !errorlevel! equ 0 (
            echo    SUCCESS!
            set /a processed_count+=1
        ) else (
            echo    [ERROR] Failed to merge this pair.
        )
    )
)

echo.
echo --------------------------------------------------
echo.
echo Batch processing complete.
echo Total pairs merged: %processed_count%
echo.
pause