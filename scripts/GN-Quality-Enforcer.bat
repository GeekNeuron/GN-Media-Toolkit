@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

cls
echo.
echo      *******************************************************
echo      * *
echo      * GN QUALITY ENFORCER v1.0                *
echo      * The Conditional Archive Processor       *
echo      * *
echo      *******************************************************
echo.

:: --- Prerequisite Check ---
ffprobe -version > nul 2>&1
if %errorlevel% neq 0 (echo [ERROR] ffprobe.exe not found! & pause & exit /b)
ffmpeg -version > nul 2>&1
if %errorlevel% neq 0 (echo [ERROR] ffmpeg.exe not found! & pause & exit /b)

set /p "targetFolder=--> Enter the path to the folder you want to scan and enforce quality on: "
if not exist "%targetFolder%" (echo [ERROR] Folder not found. & pause & exit /b)

set "processedFolder=%targetFolder%\_Processed_By_GN"
if not exist "%processedFolder%" mkdir "%processedFolder%"

echo.
echo --- Starting scan of "%targetFolder%" ---
echo Files that need processing will be re-encoded and saved to "%processedFolder%"
echo.

:: Loop through all video files in the target folder and its subfolders
for /r "%targetFolder%" %%F in (*.mp4, *.mkv, *.mov, *.avi) do (
    set "needs_processing="
    set "reason="
    set "scale_cmd="
    set "currentFile=%%F"
    
    echo --------------------------------------------------
    echo Analyzing: "!currentFile!"

    :: Check if the file is already in the processed folder to avoid loops
    echo "!currentFile!" | findstr /i /c:"%processedFolder%" >nul
    if !errorlevel! equ 0 (
        echo    -> Skipping file, as it is already in the processed folder.
    ) else (
        :: Get video stream info using ffprobe
        for /f "tokens=1,2,3 delims=," %%a in ('ffprobe -v error -select_streams v:0 -show_entries stream^=codec_name,height,bit_rate -of csv^=p^=0 "!currentFile!"') do (
            set "codec=%%a"
            set "height=%%b"
            set "bitrate=%%c"
        )

        echo    -> Codec: !codec!, Height: !height!p, Bitrate: !bitrate!
        
        :: --- Decision Logic ---
        if /i not "!codec!"=="hevc" (
            set "needs_processing=true"
            set "reason=!reason! [Not HEVC]"
        )
        if !height! gtr 1080 (
            set "needs_processing=true"
            set "reason=!reason! [Oversized Res]"
            set "scale_cmd=-vf scale=-2:1080"
        )
        
        if defined needs_processing (
            echo    -> ACTION: Needs re-encoding. Reason(s):!reason!
            echo    -> Processing... (This can take a very long time)
            ffmpeg -hide_banner -i "!currentFile!" -c:v libx265 -crf 28 -preset medium !scale_cmd! -c:a aac -b:a 128k -c:s copy "%processedFolder%\%%~nF.mkv"
            echo    -> DONE. New file saved in "_Processed_By_GN" folder.
        ) else (
            echo    -> ACTION: No processing needed. File meets standards.
        )
    )
)

echo.
echo =======================================================
echo   Scan and enforcement process complete!
echo =======================================================
pause