@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

cls
echo.
echo      *******************************************************
echo      * *
echo      * GN INSPECTOR v1.0                     *
echo      * Media File Analyzer                   *
echo      * *
echo      *******************************************************
echo.

:: --- Dependency Check ---
ffprobe -version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] ffprobe.exe not found! Please place it in the same folder.
    pause
    exit /b
)

set /p "inputFile=--> Drag & Drop your media file: "
if not exist %inputFile% (
    echo [ERROR] File not found.
    pause
    exit /b
)

cls
echo Inspecting: %~nx1
echo =======================================================
echo.

:: --- Get Format Info ---
echo ---[ General Info ]---
for /f "tokens=1,2 delims==" %%a in ('ffprobe -v error -show_entries format^=format_name,duration,size,bit_rate -of default^=noprint_wrappers^=1 %inputFile%') do (
    if "%%a"=="format_name" echo    Format      : %%b
    if "%%a"=="duration" (
        set /a "duration_int=%%b"
        set /a "h=duration_int/3600"
        set /a "m=(duration_int%%3600)/60"
        set /a "s=duration_int%%60"
        if !h! lss 10 set h=0!h!
        if !m! lss 10 set m=0!m!
        if !s! lss 10 set s=0!s!
        echo    Duration    : !h!:!m!:!s!
    )
    if "%%a"=="size" (
        set "bytes=%%b"
        if !bytes! geq 1024 set /a "bytes/=1024" & set "suffix=KB"
        if !bytes! geq 1024 set /a "bytes/=1024" & set "suffix=MB"
        if !bytes! geq 1024 set /a "bytes/=1024" & set "suffix=GB"
        echo    File Size   : !bytes! !suffix!
    )
    if "%%a"=="bit_rate" set /a "br=%%b/1000" & echo    Overall Rate: !br! kb/s
)

:: --- Get Video Stream Info ---
echo.
echo ---[ Video Stream ]---
for /f "tokens=1,2 delims==" %%a in ('ffprobe -v error -select_streams v:0 -show_entries stream^=codec_name,profile,width,height,display_aspect_ratio,r_frame_rate -of default^=noprint_wrappers^=1 %inputFile%') do (
    if "%%a"=="codec_name" echo    Codec       : %%b
    if "%%a"=="profile" echo    Profile     : %%b
    if "%%a"=="width" set "width=%%b"
    if "%%a"=="height" set "height=%%b"
    if "%%a"=="display_aspect_ratio" set "dar=%%b"
    if "%%a"=="r_frame_rate" set "fps=%%b" & set /a "fps_calc=%%b"
)
if defined width echo    Resolution  : %width%x%height% (%dar%)
if defined fps echo    Frame Rate  : %fps_calc% fps

:: --- Get Audio Stream Info ---
echo.
echo ---[ Audio Stream ]---
for /f "tokens=1,2 delims==" %%a in ('ffprobe -v error -select_streams a:0 -show_entries stream^=codec_name,profile,sample_rate,channels,channel_layout,bit_rate -of default^=noprint_wrappers^=1 %inputFile%') do (
    if "%%a"=="codec_name" echo    Codec       : %%b
    if "%%a"=="profile" echo    Profile     : %%b
    if "%%a"=="sample_rate" set /a "sr=%%b/1000" & echo    Sample Rate : !sr! kHz
    if "%%a"=="channels" echo    Channels    : %%b
    if "%%a"=="channel_layout" echo    Layout      : %%b
    if "%%a"=="bit_rate" set /a "br=%%b/1000" & echo    Bitrate     : !br! kb/s
)

echo.
echo =======================================================
pause