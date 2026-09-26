$DestPath = "D:\iphonepic"

$Shell = New-Object -ComObject Shell.Application
$ThisPC = $Shell.NameSpace(17)

# Access Internal Storage
$iPhone = $ThisPC.Items() | Where-Object { $_.Name -match "iPhone" -or $_.Name -match "Apple" } | Select-Object -First 1
$Storage = $iPhone.GetFolder.Items() | Where-Object { $_.Name -match "Internal Storage" }

if (-not (Test-Path $DestPath)) { New-Item -ItemType Directory -Force -Path $DestPath | Out-Null }

# Get all folders and sort them alphabetically/chronologically by Name
$SortedFolders = @($Storage.GetFolder.Items()) | Sort-Object Name

# Copy folders one by one in sorted order
foreach ($Folder in $SortedFolders) {
    $TargetDir = Join-Path $DestPath $Folder.Name
    if (-not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null }
    
    Write-Host "Copying: $($Folder.Name) ..." -ForegroundColor Cyan
    
    # Copy files
    $Shell.NameSpace($TargetDir).CopyHere($Folder.GetFolder.Items(), 20)
    Start-Sleep -Seconds 2
}

Write-Host "Done! All folders copied in order to $DestPath" -ForegroundColor Green
