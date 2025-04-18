# desktop_cleanup.ps1 (GIF-Speed Version – No Delays)

# Set paths
$desktop = [Environment]::GetFolderPath("Desktop")
$cleanupDir = Join-Path $desktop "Desktop Cleanup"
$docsDir = Join-Path $cleanupDir "Documents"
$mediaDir = Join-Path $cleanupDir "Media"
$otherDir = Join-Path $cleanupDir "Other"

Write-Host ""
Write-Host "==> Checking for Desktop Cleanup folder..."

# Create directories if they don't exist
if (-not (Test-Path $cleanupDir)) {
    Write-Host "No Desktop Cleanup folder detected. Creating structure..."
    New-Item -ItemType Directory -Path $docsDir -Force | Out-Null
    New-Item -ItemType Directory -Path $mediaDir -Force | Out-Null
    New-Item -ItemType Directory -Path $otherDir -Force | Out-Null
} else {
    Write-Host "Desktop Cleanup folder already exists. Skipping creation."
}

# Initialize counters and logs
$docsCount = 0; $mediaCount = 0; $otherCount = 0
$docsSize = 0; $mediaSize = 0; $otherSize = 0
$docsLog = @(); $mediaLog = @(); $otherLog = @()

Write-Host ""
Write-Host "==> Scanning Desktop files and transferring..."

# Loop through files on Desktop
Get-ChildItem -Path $desktop -File | ForEach-Object {
    $file = $_
    $filename = $file.Name
    $extension = $file.Extension.ToLower().TrimStart('.')

    # Skip the cleanup folder and scripts
    if ($file.FullName -like "$cleanupDir*" -or $filename -eq "desktop_cleanup.ps1" -or $filename -eq "desktop_restore.ps1") {
        return
    }

    $sizeMB = [Math]::Round($file.Length / 1MB, 2)

    if ($extension -in @('pdf','doc','docx','txt','xlsx','xls','ppt','pptx')) {
        Move-Item $file.FullName -Destination (Join-Path $docsDir $filename)
        $docsLog += " - $filename ($sizeMB MB) moved to Documents"
        $docsCount++
        $docsSize += $sizeMB
    } elseif ($extension -in @('jpg','jpeg','png','gif','mp4','mov','avi','mp3','wav')) {
        Move-Item $file.FullName -Destination (Join-Path $mediaDir $filename)
        $mediaLog += " - $filename ($sizeMB MB) moved to Media"
        $mediaCount++
        $mediaSize += $sizeMB
    } else {
        Move-Item $file.FullName -Destination (Join-Path $otherDir $filename)
        $otherLog += " - $filename ($sizeMB MB) moved to Other"
        $otherCount++
        $otherSize += $sizeMB
    }
}

# Output logs
Write-Host ""
Write-Host "==================== RESULTS ====================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Documents:"
$docsLog | ForEach-Object { Write-Host $_ }
Write-Host ""

Write-Host "Media:"
$mediaLog | ForEach-Object { Write-Host $_ }
Write-Host ""

Write-Host "Other:"
$otherLog | ForEach-Object { Write-Host $_ }
Write-Host ""

# Final Summary
Write-Host "==================== SUMMARY ====================" -ForegroundColor Cyan
Write-Host "Documents: $docsCount file(s), $docsSize MB"
Write-Host "Media:     $mediaCount file(s), $mediaSize MB"
Write-Host "Other:     $otherCount file(s), $otherSize MB"
Write-Host ""
Write-Host "Desktop cleanup complete." -ForegroundColor Green