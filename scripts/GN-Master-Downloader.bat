@echo off
chcp 65001 > nul

cls
echo.
echo      *******************************************************
echo      * *
echo      * GN MASTER DOWNLOADER v1.0               *
echo      * The Smart YouTube Workflow              *
echo      * *
echo      *******************************************************
echo.

:: --- Prerequisite Check ---
yt-dlp --version > nul 2>&1
if %errorlevel% neq 0 (echo [ERROR] yt-dlp.exe not found! & pause & exit /b)
ffmpeg -version > nul 2>&1
if %errorlevel% neq 0 (echo [ERROR] ffmpeg.exe not found! & pause & exit /b)

set /p "youtube_url=--> Enter the YouTube video URL: "
if not defined youtube_url exit /b

:: --- Step 1: Create a temporary folder for this project ---
set "temp_folder=_Project_%time::=.%"
mkdir "%temp_folder%"
echo.
echo [INFO] A temporary folder named "%temp_folder%" has been created for processing.

:: --- Step 2: Download the best quality video and audio ---
echo.
echo [1/5] Downloading best video and audio from YouTube...
yt-dlp.exe -o "%temp_folder%\original.%(ext)s" -f "bestvideo+bestaudio/best" "%youtube_url%"
if %errorlevel% neq 0 (echo [ERROR] Download failed. & pause & exit /b)
for %%F in ("%temp_folder%\original.*") do set "original_video=%%F"

:: --- Step 3: Download available Persian and English subtitles ---
echo.
echo [2/5] Searching for and downloading subtitles (fa, en)...
yt-dlp.exe --write-sub --sub-langs "fa,en,en-US,en-GB" --skip-download -o "%temp_folder%\sub" "%youtube_url%"

:: --- Step 4: Compress the downloaded video ---
echo.
echo [3/5] Compressing video to x265/AAC standard... (This may take a long time)
set "compressed_video=%temp_folder%\compressed.mp4"
ffmpeg.exe -hide_banner -i "%original_video%" -c:v libx265 -crf 28 -preset medium -c:a aac -b:a 128k "%compressed_video%"
if %errorlevel% neq 0 (echo [ERROR] Compression failed. & pause & exit /b)

:: --- Step 5: Merge the final video with all found subtitles ---
echo.
echo [4/5] Merging compressed video with all subtitles into a final MKV file...
set "final_output=%~n1 Final Video.mkv"
set "subtitle_inputs="
for %%S in ("%temp_folder%\*.srt" "%temp_folder%\*.vtt") do (
    set "subtitle_inputs=!subtitle_inputs! -i "%%S""
)
set "map_cmd=-map 0"
set /a "sub_count=0"
for %%S in ("%temp_folder%\*.srt" "%temp_folder%\*.vtt") do (
    set /a "sub_count+=1"
    set "map_cmd=!map_cmd! -map !sub_count!"
)
setlocal enabledelayedexpansion
ffmpeg.exe -hide_banner -i "%compressed_video%" !subtitle_inputs! -c copy !map_cmd! "%final_output%"
endlocal
if %errorlevel% neq 0 (echo [ERROR] Final merge failed. & pause & exit /b)

:: --- Step 6: Cleanup ---
echo.
echo [5/5] Cleaning up temporary files...
rmdir /s /q "%temp_folder%"

echo.
echo =======================================================
echo   WORKFLOW COMPLETE!
echo   Final file saved as: %final_output%
echo =======================================================
pause