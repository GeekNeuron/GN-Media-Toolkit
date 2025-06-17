@echo off
chcp 65001 > nul

cls
echo.
echo      *******************************************************
echo      * *
echo      * GN SUBTITLE SEARCH v1.0                 *
echo      * Smart Subtitle Website Search Launcher  *
echo      * *
echo      *******************************************************
echo.

set /p "query=--> Enter the English name of the Movie or Series: "
if not defined query exit /b

:: Replace spaces with %20 for URL encoding
set "query_encoded=%query: =%%20%"

echo.
echo Opening search results in your browser for "%query%"...
echo.

:: Open search results in different subtitle websites
start "" "https://subscene.com/subtitles/searchbytitle?query=%query_encoded%"
start "" "https://www.opensubtitles.org/en/search/sublanguageid-all/moviename-%query_encoded%"
start "" "https://worldsubtitle.net/?s=%query_encoded%"

echo.
echo Your browser has been opened with the search results.
pause