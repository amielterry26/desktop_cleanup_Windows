# desktop_restore.ps1 (GIF-Speed Version – No Delays)

# Restores files from the 'Desktop Cleanup' structure back to the Desktop

# Set paths
$desktop = [Environment]::GetFolderPath("Desktop")
$cleanupDir = Join-Path $desktop "Desktop Cleanup"
$docsDir = Join-Path $cleanupDir "Documents"
$mediaDir = Join-Path $cleanupDir "Media"
$otherDir = Join-Path $cleanupDir "Other"

Write-Host ""
Write-Host "==> Starting desktop restore..."

# Safety check
if (-not (Test-Path $cleanupDir)) {
    Write-Host "No Desktop Cleanup folder found. Nothing to restore." -ForegroundColor Yellow
    exit
}

# Initialize counters
$docsCount = 0; $mediaCount = 0; $otherCount = 0

# Function to restore files from a category folder
function Restore-Files {
    param (
        [string]$sourcePath,
        [string]$categoryName,
        [ref]$countVar
    )

    if (-not (Test-Path $sourcePath)) {
        return
    }

    Get-ChildItem -Path $sourcePath -File | ForEach-Object {
        $file = $_
        $filename = $file.Name

        # Skip this restore script and the cleanup script
        if ($filename -eq "desktop_cleanup.ps1" -or $filename -eq "desktop_restore.ps1") {
            return
        }

        Move-Item -Path $file.FullName -Destination (Join-Path $desktop $filename)
        Write-Host " - Restored $filename from $categoryName"
        $countVar.Value++
    }
}

Write-Host ""
Write-Host "================== RESTORE LOG ==================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Restoring Documents..."
Restore-Files -sourcePath $docsDir -categoryName "Documents" -countVar ([ref]$docsCount)
Write-Host ""

Write-Host "Restoring Media..."
Restore-Files -sourcePath $mediaDir -categoryName "Media" -countVar ([ref]$mediaCount)
Write-Host ""

Write-Host "Restoring Other..."
Restore-Files -sourcePath $otherDir -categoryName "Other" -countVar ([ref]$otherCount)
Write-Host ""

Write-Host "================== SUMMARY ==================" -ForegroundColor Cyan
Write-Host "Documents: $docsCount file(s) restored"
Write-Host "Media:     $mediaCount file(s) restored"
Write-Host "Other:     $otherCount file(s) restored"
Write-Host ""
Write-Host "Restore complete. Files returned to Desktop." -ForegroundColor Green