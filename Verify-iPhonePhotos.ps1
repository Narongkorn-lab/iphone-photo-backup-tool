# 1. Set the destination path on PC
$DestPath = "D:\iphonepic"

# 2. Connect to Windows Shell COM API
$shell = New-Object -ComObject Shell.Application
$myComputer = $shell.NameSpace(0x11) # This PC

# 3. Find connected iPhone device
$iphone = $myComputer.Items() | Where-Object { $_.Name -like "*iPhone*" }

if (-not $iphone) {
    Write-Host "[ERROR] iPhone not detected! Please connect via USB and tap 'Trust This Computer'." -ForegroundColor Red
    return
}

Write-Host "[>>] OPTIMIZED SCAN RUNNING..." -ForegroundColor Yellow
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

# 4. FAST MTP COUNT (iPhone)
$internalStorage = $iphone.GetFolder.Items() | Where-Object { $_.Name -eq "Internal Storage" }
$iphoneFileCount = 0

if ($internalStorage) {
    foreach ($item in $internalStorage.GetFolder.Items()) {
        if ($item.IsFolder) {
            $iphoneFileCount += $item.GetFolder.Items().Count
        } else {
            $iphoneFileCount++
        }
    }
} else {
    Write-Host "[WARNING] 'Internal Storage' not found. Please unlock your iPhone screen." -ForegroundColor DarkYellow
    return
}

# 5. FAST PC COUNT (.NET Framework Engine)
$pcFileCount = 0
if (Test-Path $DestPath) {
    $pcFileCount = @([System.IO.Directory]::EnumerateFiles($DestPath, "*.*", [System.IO.SearchOption]::AllDirectories)).Count
}

$stopwatch.Stop()
$scanTime = $stopwatch.Elapsed.TotalSeconds.ToString("0.00")

# 6. Display comparison summary
Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "*** HIGH-SPEED FILE COUNT SUMMARY ***" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "[TIME] Scan completed in : $scanTime seconds" -ForegroundColor Gray
Write-Host "[iOS] Total Files on iPhone         : $iphoneFileCount"
Write-Host "[PC]  Total Files on PC ($DestPath) : $pcFileCount"
Write-Host "------------------------------------------"

if ($pcFileCount -ge $iphoneFileCount -and $iphoneFileCount -gt 0) {
    Write-Host "[SUCCESS] Verification Successful! All files are safely backed up on PC." -ForegroundColor Green
} else {
    $diff = $iphoneFileCount - $pcFileCount
    Write-Host "[WARNING] $diff file(s) missing on PC." -ForegroundColor Red
}
Write-Host "==========================================" -ForegroundColor Cyan
