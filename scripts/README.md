# 🚀 The GN Media Toolkit (Galactic Edition)

<p align="center">
  <strong>An all-in-one command-line suite designed to manage, convert, and automate your entire media library.</strong>
</p>
<p align="center">
  Built upon the power of legendary open-source tools:
  <br>
  <strong>FFmpeg</strong> | <strong>yt-dlp</strong> | <strong>ImageMagick</strong>
</p>

---

## 📖 About This Project

The **GN Toolkit** is the result of an exploratory journey to challenge the maximum capabilities of command-line tools. What began as a simple need to merge files has evolved into a complete software suite with 16 distinct tools, capable of performing complex tasks including intelligent workflows, conditional processing, and full automation. This toolkit is designed for power users, media archivists, and anyone who seeks absolute control over their media files.

---

## ⚙️ Prerequisites & Setup (Launch Checklist)

To get the toolkit operational, please follow these three steps carefully.

### Step 1: Get The Scripts
Place all 16 script files (`.bat`) from the `scripts` folder of this repository into a new, single folder on your computer. This will be your toolkit's main directory.

### Step 2: Install The Engines
This suite relies on 3 core application groups. Download them from the links below and place their executable files (`.exe`) in the **same folder** where you placed the scripts.

* **FFmpeg Suite (includes `ffmpeg`, `ffprobe`, `ffplay`):**
    * **Download Link:** [**Gyan.dev FFmpeg Builds (Full Release Version)**](https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z)
    * **Instructions:** After downloading, extract the `.7z` archive using a program like 7-Zip or WinRAR. Copy the **three files** `ffmpeg.exe`, `ffprobe.exe`, and `ffplay.exe` from the `bin` folder and place them in your toolkit directory.

* **yt-dlp (for YouTube Downloading):**
    * **Download Link:** [**yt-dlp.exe (Latest Release)**](https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe)
    * **Instructions:** Simply place the downloaded `yt-dlp.exe` file directly into your toolkit directory.

* **ImageMagick (for Image Processing):**
    * **Download Link:** [**ImageMagick Official Download Page**](https://imagemagick.org/script/download.php)
    * **Instructions:** Download and **install** one of the Windows versions.
    * **Crucial Installation Step:** During installation, make sure you check the box that says **"Add application directory to your system PATH"**. This is essential for certain tools to work correctly.

### Step 3: Final Systems Check
Your toolkit folder should now contain **16 script files** and **4 executable files** (`ffmpeg.exe`, `ffprobe.exe`, `ffplay.exe`, `yt-dlp.exe`). ImageMagick should be installed on your system.

---

## 💡 How to Use the Toolkit

The easiest way to start is by running the main launcher file: **`GN-Toolkit-v3-Final.bat`**.

This will present you with a central dashboard and a categorized menu, giving you access to all the other tools. Detailed instructions for each individual tool are provided below.

---

## 🚀 The Tools: A Comprehensive Guide

Here is a detailed breakdown of every tool included in the suite.

### 🌌 Galactic Workflows

> These are advanced meta-scripts that combine multiple tools into a single, intelligent workflow.

---

#### 1. `GN-Master-Downloader.bat`
*The "one-click" workflow for downloading, perfecting, and archiving YouTube content.*

* **About this tool:** This is an automation powerhouse. It takes a single YouTube URL and performs a complete series of actions: downloading the best quality video, grabbing all available subtitles, compressing the video to a space-saving format, and merging everything into a single, final file. It's the ultimate tool for effortless content acquisition.
* **Key Features:**
    * Automates a 5-step workflow.
    * Downloads the best available video and audio streams from YouTube.
    * Automatically fetches both English and Persian subtitles if they exist.
    * Re-encodes the video to the efficient x265 codec to save disk space.
    * Merges the compressed video and all subtitles into a clean, final `.mkv` file.
* **Dependencies:** `yt-dlp.exe`, `ffmpeg.exe`.
* **How to Use:**
    1.  Run the script (ideally from the main Toolkit launcher).
    2.  When prompted, paste the full URL of the YouTube video you want to process.
    3.  Press Enter and wait. The script will show its progress through each step. This process can be very time-consuming.

---

#### 2. `GN-Quality-Enforcer.bat`
*An intelligent robotic assistant for maintaining the quality and standards of your entire media archive.*

* **About this tool:** This is a "Conditional Processor." It doesn't just blindly process files; it first analyzes them with `ffprobe` and then makes intelligent decisions. It scans a folder of your videos, checks their technical properties against defined standards, and only re-encodes the files that need fixing.
* **Key Features:**
    * Analyzes file codec, resolution, and bitrate before acting.
    * Only processes files that fail the quality check (e.g., are not x265, are higher than 1080p).
    * Recursively scans all subfolders within the target directory.
    * Saves newly processed files into a `_Processed_By_GN` subfolder, leaving your original files untouched.
* **Dependencies:** `ffprobe.exe`, `ffmpeg.exe`.
* **How to Use:**
    1.  Run the script from the main Toolkit launcher.
    2.  You will be prompted to enter the full path to the folder you want to scan.
    3.  Press Enter. The script will begin scanning every video file. It will print its analysis and decision for each file.

---

#### 3. `GN-Scene-Creator.bat`
*A "Synergy Project" that combines FFmpeg and ImageMagick to create beautiful cinematic storyboards.*

* **About this tool:** This unique tool creates a visual summary of your video. It extracts several keyframes and uses the powerful ImageMagick engine to stitch them together into a single, high-quality image, complete with a title overlay.
* **Key Features:**
    * Smartly extracts 9 representative screenshots from calculated intervals in the video.
    * Uses ImageMagick to arrange the screenshots into a professional 3x3 grid.
    * Automatically adds the video's filename as a stylish title.
* **Dependencies:** `ffmpeg.exe`, `ffprobe.exe`, and a system-wide installation of **ImageMagick**.
* **How to Use:**
    1.  Run the script from the main Toolkit launcher.
    2.  Drag and drop the video file you want to process into the window and press Enter.
    3.  The final `Scene Card.png` image will be saved in the same folder as your original video.

---

### 🛠️ Core Tools: Creation, Conversion & Editing

---

#### 4. `GN-Ultimate-Merger.bat`
*The all-in-one tool for combining video, audio, and subtitle streams.*

* **About this tool:** This tool allows you to merge (mux) separate media streams into a standard `.mp4` or `.mkv` container. The process is lossless, meaning it does not reduce the quality of your original streams.
* **Key Features:**
    * Lossless merging via stream copy.
    * Supports multiple audio tracks and soft subtitle tracks.
    * Can embed a JPG or PNG image as cover art.
* **Dependencies:** `ffmpeg.exe`.
* **How to Use:** Double-click and follow the interactive prompts for Video, Audio, Cover Art, etc.

---

#### 5. `GN-Pro-Compressor.bat`
*A professional video compression and conversion workstation.*

* **About this tool:** Re-encodes video files to reduce their size while maintaining high quality. It gives you precise control over the output.
* **Key Features:**
    * Choice between `x265` (high efficiency) and `x264` (high compatibility) encoders.
    * Quality control using Constant Rate Factor (CRF).
    * Speed vs. efficiency control via presets.
    * Reports original size, final size, and total space saved.
* **Dependencies:** `ffmpeg.exe`.
* **How to Use:** Run the script, drag and drop your video file, and answer the questions to configure your compression settings.

---

#### 6. `GN-Audio-Converter.bat`
*A dedicated, streamlined tool for all your audio format conversion needs.*

* **About this tool:** Focuses on one task: converting audio files between different formats and bitrates.
* **Key Features:**
    * Convert between `mp3`, `aac`, `ogg`, `flac`, `wav`, and more.
    * Specify the desired audio bitrate (e.g., `128k`, `192k`, `320k`).
* **Dependencies:** `ffmpeg.exe`.
* **How to Use:** Run the script, drop your source audio file, then type the desired output format and bitrate.

---

#### 7. `GN-QuickFix.bat`
*Your go-to toolbox for solving common video problems.*

* **About this tool:** A menu-driven script for simple edits that would otherwise require a heavy video editor.
* **Key Features:**
    * **Rotate Video:** Fix videos filmed sideways or upside down.
    * **Add Watermark:** Permanently embed your logo (`.png`) onto a video in any corner.
* **Dependencies:** `ffmpeg.exe`.
* **How to Use:** Run the script and choose an option from the menu, then follow the prompts.

---

#### 8. `GN-Extractor.bat`
*A multi-purpose tool for pulling content out of your media files.*

* **About this tool:** Instead of combining, this tool extracts specific parts of a video file.
* **Key Features:**
    * **Extract Audio:** Rips the full audio track from a video without quality loss.
    * **Create GIF:** Generates a high-quality animated GIF from a specified clip.
    * **Take Screenshot:** Saves a single, pixel-perfect frame from a precise timestamp as a `.png` image.
* **Dependencies:** `ffmpeg.exe`.
* **How to Use:** Run the script, choose what you want to extract from the menu, and follow the prompts.

---

### 🌐 Subtitle & Online Tools

---

#### 9. `GN-Subtitle-Downloader.bat`
*A powerful subtitle utility for YouTube.*

* **About this tool:** This script connects to YouTube, finds all available subtitle languages for a video, and downloads the one you choose.
* **Key Features:**
    * Lists all available subtitle tracks with their language codes.
    * Downloads your selected subtitle as a separate `.srt` or `.vtt` file.
    * Does not download the video itself, saving time and bandwidth.
* **Dependencies:** `yt-dlp.exe`.
* **How to Use:** Run the script, paste a YouTube URL, view the list of available subtitles, and then enter the language code you wish to download.

---

#### 10. `GN-Subtitle-Search.bat`
*A smart search assistant for finding subtitles online.*

* **About this tool:** Instead of you manually opening browser tabs and searching, this helper script does it for you.
* **Key Features:**
    * Prompts for a movie or series name.
    * Automatically opens your default web browser to the search results pages on Subscene, OpenSubtitles, and other popular sites.
* **Dependencies:** None (uses built-in Windows commands).
* **How to Use:** Run the script, type the English name of the movie or series you are looking for, and press Enter.

---

#### 11. `GN-Stream-Tester.bat`
*A simple utility for testing and playing online media streams.*

* **About this tool:** Uses `ffplay` to connect directly to an internet stream URL to check if it's live and playable.
* **Key Features:**
    * Plays internet radio stations, live video feeds, and other streamable URLs.
    * A great diagnostic tool for checking if a stream link is valid.
* **Dependencies:** `ffplay.exe`.
* **How to Use:** Run the script, paste the full URL of the stream, and press Enter.

---

### 🔍 Analysis & Playback

---

#### 12. `GN-Inspector.bat`
*Your media file's technical resume.*

* **About this tool:** Uses `ffprobe` to read a media file's metadata and present it in a clean, human-readable format.
* **Key Features:**
    * Displays general info: format, duration, file size, overall bitrate.
    * Displays video info: codec, profile, resolution, aspect ratio, frame rate.
    * Displays audio info: codec, sample rate, channels, bitrate.
* **Dependencies:** `ffprobe.exe`.
* **How to Use:** Run the script and drag and drop any media file into the window.

---

#### 13. `GN-Visual-Analyzer.bat`
*A visual analysis player powered by `ffplay`.*

* **About this tool:** Goes beyond text-based analysis by providing a live, graphical representation of a file's audio.
* **Key Features:**
    * **Waveform Mode:** Displays the sound waves in real-time as the file plays.
    * **Spectrum Mode:** Displays the audio frequencies (bass, mids, treble) in real-time.
* **Dependencies:** `ffplay.exe`.
* **How to Use:** Run the script, drop in a media file, and then choose your desired analysis mode from the menu.

---

#### 14. `GN-Quick-Preview.bat`
*The simplest, most lightweight way to view a media file.*

* **About this tool:** A minimalist player that opens a clean, borderless window, plays the file, and then closes automatically.
* **Key Features:**
    * Extremely fast startup.
    * No window borders or controls for a clean look.
    * `autoexit` feature closes the window when playback is finished.
* **Dependencies:** `ffplay.exe`.
* **How to Use:** This tool is optimized for drag-and-drop. Simply drag any media file and drop it directly onto the `GN-Quick-Preview.bat` icon.

---

### 🤖 Automation

---

#### 15. `GN-Batch-Processor.bat`
*A fire-and-forget automation tool for merging files in bulk.*

* **About this tool:** Scans a folder for pairs of video and audio files that share the same name (e.g., `video1.mp4` and `video1.mp3`) and merges them automatically.
* **Key Features:**
    * Processes an entire folder at once.
    * Uses lossless stream copy for fast merging.
    * Saves all merged files neatly into a `_Merged_Output` subfolder.
* **Dependencies:** `ffmpeg.exe`.
* **How to Use:** Place this script *inside* the folder you want to process, then double-click it. (Note: When run from the main Toolkit, it will ask you for the target folder path).

---
<p align="center">
  <em>This toolkit began with curiosity and evolved through collaboration. Enjoy exploring the endless universe of the command line!</em>
</p>
