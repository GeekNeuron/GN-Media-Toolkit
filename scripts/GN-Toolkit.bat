@echo off
chcp 65001 > nul

:: ###############################################################
:: # GN MEDIA TOOLKIT v3.0 (Final Version)                       #
:: # The Ultimate Dashboard for all 15 GN Media Tools            #
:: # Including Galactic Workflow Projects                        #
:: ###############################################################

:: Get the path of the toolkit's directory
set "ToolkitPath=%~dp0"

:mainMenu
cls
echo.
echo      *******************************************************
echo      * *
echo      * GN  MEDIA  TOOLKIT  v3.0  - FINAL      *
echo      * Your Complete, All-in-One Media Suite   *
echo      * *
echo      *******************************************************
echo.
echo.
echo      --- [ GALACTIC WORKFLOWS ] ---
echo.
echo        1. Smart YouTube Downloader & Processor
echo        2. Enforce Quality Standards on a Folder
echo        3. Create Cinematic Scene Card from Video
echo.
echo      --- [ CORE TOOLS: CREATION & CONVERSION ] ---
echo.
echo        4. Merge Files (Video, Audio, Subs)
echo        5. Compress or Convert a VIDEO file
echo        6. Convert an AUDIO file
echo.
echo      --- [ EDITING & EXTRACTION ] ---
echo.
echo        7. Quick Fixes (Rotate / Watermark)
echo        8. Extract from Video (Audio / GIF / Frame)
echo.
echo      --- [ SUBTITLE & ONLINE TOOLS ] ---
echo.
echo        9. Download Subtitle from YouTube
echo       10. Search Subtitle Websites
echo       11. Test an Online Stream
echo.
echo      --- [ ANALYSIS & PLAYBACK ] ---
echo.
echo       12. Inspect Media File Details
echo       13. Visual Audio Analyzer (Waveform/Spectrum)
echo       14. Quick Preview a File
echo.
echo      --- [ AUTOMATION ] ---
echo.
echo       15. Process a Whole Folder (Simple Merge)
echo.
echo      -------------------------------------------------------
echo.
echo        Q. Quit Toolkit
echo.
set /p "choice=--> Please enter your choice and press Enter: "

if /i "%choice%"=="1" call "%ToolkitPath%GN-Master-Downloader.bat"
if /i "%choice%"=="2" goto runInTargetFolder "GN-Quality-Enforcer.bat" "scan and enforce quality on"
if /i "%choice%"=="3" call "%ToolkitPath%GN-Scene-Creator.bat"
if /i "%choice%"=="4" call "%ToolkitPath%GN-Ultimate-Merger.bat"
if /i "%choice%"=="5" call "%ToolkitPath%GN-Pro-Compressor.bat"
if /i "%choice%"=="6" call "%ToolkitPath%GN-Audio-Converter.bat"
if /i "%choice%"=="7" call "%ToolkitPath%GN-QuickFix.bat"
if /i "%choice%"=="8" call "%ToolkitPath%GN-Extractor.bat"
if /i "%choice%"=="9" call "%ToolkitPath%GN-Subtitle-Downloader.bat"
if /i "%choice%"=="10" call "%ToolkitPath%GN-Subtitle-Search.bat"
if /i "%choice%"=="11" call "%ToolkitPath%GN-Stream-Tester.bat"
if /i "%choice%"=="12" call "%ToolkitPath%GN-Inspector.bat"
if /i "%choice%"=="13" call "%ToolkitPath%GN-Visual-Analyzer.bat"
if /i "%choice%"=="14" goto runQuickPreview
if /i "%choice%"=="15" goto runInTargetFolder "GN-Batch-Processor.bat" "process with simple merge"
if /i "%choice%"=="Q" exit