# 📸 iOS MTP Robust Photo Backup Tool for Windows

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://microsoft.com/powershell)
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)](https://windows.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A lightweight, robust PowerShell automation script designed to bypass Windows MTP (Media Transfer Protocol) dropouts and timeout bugs when backing up media files from iPhone to Windows PC.

---

## 💥 The Problem
When copying large photo collections from an iPhone to Windows via USB, users frequently encounter:
- MTP Connection Drops (`A device attached to the system is not functioning`)
- Missing or non-standard `DCIM` root directory mappings in certain iOS/Windows builds
- Freezing when copying multiple folders simultaneously

## ✨ Features
- 🔄 **Sequential Folder Processing:** Transfers folders one by one to avoid MTP stack overload.
- 🔡 **Chronological Sorting:** Automatically sorts directories alphabetically/chronologically before copying.
- 🛡️ **Direct Internal Storage Target:** Bypasses missing `DCIM` directory checks by indexing `Internal Storage` directly.
- 🌐 **Windows Shell COM Integration:** Interfaces directly with Windows Virtual System Folders without assigned drive letters.

---

## 📷 File Types & Original Quality
By enabling **Keep Originals** on your iPhone, this script preserves the exact raw media files without quality loss or live-conversion bottlenecks:
- **Photos:** `.HEIC` (High Efficiency Image Container), `.JPG`, `.PNG`
- **Videos:** `.MOV` (Apple QuickTime Movie Format), `.MP4`
- **Live Photos:** Retains both the `.HEIC` image and its matching `.MOV` video clip.

---

## 🚀 Quick Start

### 1. iPhone Prerequisites (Crucial)
To prevent USB disconnection bugs during file transfer:
* Go to **Settings > Photos** > scroll to bottom and select **Keep Originals** under *Transfer to Mac or PC*.
* Set **Settings > Display & Brightness > Auto-Lock** to **Never**.

### 2. Run the Script
1. Connect your iPhone via USB and tap **Trust This Computer**.
2. Download `Backup-iPhonePhotos.ps1`.
3. Open **PowerShell ISE** (Run as Administrator) and execute:

```powershell
.\Backup-iPhonePhotos.ps1
```
> **Note:** The default destination path is `D:\iphonepic`. You can edit `$DestPath` inside the script to change your preferred backup location.

---

## 📜 License
Distributed under the MIT License.
