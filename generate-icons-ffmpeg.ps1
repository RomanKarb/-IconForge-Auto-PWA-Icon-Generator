# ====================================================================
# PWA Icon Generator Script for PowerShell (FFmpeg)
# Генератор иконок для всех платформ (iOS, Android, Web, PWA)
# ====================================================================
#
# Требования: FFmpeg должен быть установлен
# Загрузить: https://ffmpeg.org/download.html
# Или через winget: winget install ffmpeg
#
# Использование:
#   1. Разместите иконку 512x512px в папке скрипта с именем "source-icon.png"
#   2. Запустите: .\generate-icons-ffmpeg.ps1
#   3. Дождитесь завершения
#   4. Откройте header.txt и скопируйте готовый HTML
#
# ====================================================================

param(
    [string]$SourceIcon = "source-icon.png",
    [string]$OutputDir = "icons",
    [string]$HeaderFile = "header.txt",
    [string]$ProjectName = "My App"
)

# Цвета для вывода
$ErrorColor = "Red"
$SuccessColor = "Green"
$InfoColor = "Cyan"
$WarningColor = "Yellow"

Write-Host "`n" -ForegroundColor $InfoColor
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor $InfoColor
Write-Host "║         PWA ICON GENERATOR v1.0 (PowerShell + FFmpeg)         ║" -ForegroundColor $InfoColor
Write-Host "║    Генератор иконок для iOS, Android, Web и PWA               ║" -ForegroundColor $InfoColor
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor $InfoColor
Write-Host "`n"

# ====== ПРОВЕРКА FFMPEG ======
Write-Host "🔍 Проверяю FFmpeg..." -ForegroundColor $InfoColor

try {
    $ffmpeg = Get-Command ffmpeg -ErrorAction Stop
    Write-Host "✓ FFmpeg найден: $($ffmpeg.Source)" -ForegroundColor $SuccessColor
} catch {
    Write-Host "❌ ОШИБКА: FFmpeg не найден!" -ForegroundColor $ErrorColor
    Write-Host "`nПожалуйста установите FFmpeg:" -ForegroundColor $WarningColor
    Write-Host "https://ffmpeg.org/download.html" -ForegroundColor $InfoColor
    Write-Host "`nИли через winget:" -ForegroundColor $WarningColor
    Write-Host "winget install ffmpeg" -ForegroundColor $InfoColor
    Write-Host "`nПосле установки перезагрузите PowerShell и запустите скрипт снова." -ForegroundColor $WarningColor
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

# ====== ПРОВЕРКА ИСХОДНОЙ ИКОНКИ ======
Write-Host "`n🔍 Проверяю исходную иконку..." -ForegroundColor $InfoColor

if (-not (Test-Path $SourceIcon)) {
    Write-Host "❌ ОШИБКА: Файл '$SourceIcon' не найден!" -ForegroundColor $ErrorColor
    Write-Host "`nПожалуйста разместите иконку 512x512px с именем '$SourceIcon' в папке скрипта." -ForegroundColor $WarningColor
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host "✓ Найдена исходная иконка: $SourceIcon" -ForegroundColor $SuccessColor

# ====== СОЗДАНИЕ ДИРЕКТОРИЙ ======
Write-Host "`n📁 Создаю директории..." -ForegroundColor $InfoColor

$dirs = @(
    $OutputDir,
    "$OutputDir\apple",
    "$OutputDir\android",
    "$OutputDir\android\mipmap-ldpi",
    "$OutputDir\android\mipmap-mdpi",
    "$OutputDir\android\mipmap-hdpi",
    "$OutputDir\android\mipmap-xhdpi",
    "$OutputDir\android\mipmap-xxhdpi",
    "$OutputDir\android\mipmap-xxxhdpi"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  ✓ Создана папка: $dir" -ForegroundColor $SuccessColor
    }
}

# ====== ФУНКЦИЯ ДЛЯ ГЕНЕРАЦИИ ИКОНОК ======
function Generate-Icon {
    param(
        [string]$OutputPath,
        [int]$Size,
        [string]$Label
    )
    
    Write-Host "   ↳ $Label ($($Size)x$($Size))" -ForegroundColor $InfoColor
    & ffmpeg -i "$SourceIcon" -vf "scale=$($Size):$($Size)" "$OutputPath" -y 2>$null
    
    if (Test-Path $OutputPath) {
        Write-Host "     ✓ Сохранено" -ForegroundColor $SuccessColor
    } else {
        Write-Host "     ❌ Ошибка при создании" -ForegroundColor $ErrorColor
    }
}

# ====== ГЕНЕРАЦИЯ ВЕБ ИКОНОК ======
Write-Host "`n🌐 Генерирую веб иконки..." -ForegroundColor $InfoColor
Generate-Icon "$OutputDir\icon-72.png" 72 "icon-72.png"
Generate-Icon "$OutputDir\icon-96.png" 96 "icon-96.png"
Generate-Icon "$OutputDir\icon-128.png" 128 "icon-128.png"
Generate-Icon "$OutputDir\icon-144.png" 144 "icon-144.png (Windows tiles)"
Generate-Icon "$OutputDir\icon-192.png" 192 "icon-192.png (Android)"
Generate-Icon "$OutputDir\icon-192-maskable.png" 192 "icon-192-maskable.png (PWA)"
Generate-Icon "$OutputDir\icon-256.png" 256 "icon-256.png"
Generate-Icon "$OutputDir\icon-384.png" 384 "icon-384.png"
Generate-Icon "$OutputDir\icon-512.png" 512 "icon-512.png (PWA splash)"

# ====== ГЕНЕРАЦИЯ APPLE ИКОНОК ======
Write-Host "`n🍎 Генерирую Apple иконки (iOS)..." -ForegroundColor $InfoColor
Generate-Icon "$OutputDir\apple\Icon-Small.png" 29 "Icon-Small.png"
Generate-Icon "$OutputDir\apple\Icon-Small@2x.png" 58 "Icon-Small@2x.png"
Generate-Icon "$OutputDir\apple\Icon-Small@3x.png" 87 "Icon-Small@3x.png"
Generate-Icon "$OutputDir\apple\Icon-Small-40.png" 40 "Icon-Small-40.png"
Generate-Icon "$OutputDir\apple\Icon-Small-40@2x.png" 80 "Icon-Small-40@2x.png"
Generate-Icon "$OutputDir\apple\Icon-Small-40@3x.png" 120 "Icon-Small-40@3x.png"
Generate-Icon "$OutputDir\apple\Icon-60@2x.png" 120 "Icon-60@2x.png"
Generate-Icon "$OutputDir\apple\Icon-60@3x.png" 180 "Icon-60@3x.png"
Generate-Icon "$OutputDir\apple\Icon-76.png" 76 "Icon-76.png"
Generate-Icon "$OutputDir\apple\Icon-76@2x.png" 152 "Icon-76@2x.png"
Generate-Icon "$OutputDir\apple\Icon-83.5@2x.png" 167 "Icon-83.5@2x.png"

# ====== ГЕНЕРАЦИЯ ANDROID ИКОНОК ======
Write-Host "`n🤖 Генерирую Android иконки (мипмапы)..." -ForegroundColor $InfoColor
Generate-Icon "$OutputDir\android\mipmap-ldpi\ic_launcher.png" 36 "mipmap-ldpi"
Generate-Icon "$OutputDir\android\mipmap-mdpi\ic_launcher.png" 48 "mipmap-mdpi"
Generate-Icon "$OutputDir\android\mipmap-hdpi\ic_launcher.png" 72 "mipmap-hdpi"
Generate-Icon "$OutputDir\android\mipmap-xhdpi\ic_launcher.png" 96 "mipmap-xhdpi"
Generate-Icon "$OutputDir\android\mipmap-xxhdpi\ic_launcher.png" 144 "mipmap-xxhdpi"
Generate-Icon "$OutputDir\android\mipmap-xxxhdpi\ic_launcher.png" 192 "mipmap-xxxhdpi"

# ====== ГЕНЕРАЦИЯ HTML HEADER ======
Write-Host "`n📝 Генерирую HTML header..." -ForegroundColor $InfoColor

$htmlHeader = @"
# HTML HEADER ДЛЯ СКОПИРОВАНИЯ В index.html

## СКОПИРУЙТЕ БЕЗ ЭТИХ КОММЕНТАРИЕВ:

Favicon & Icons (вставьте в <head>):

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/favicon.ico" />

<!-- Apple Touch Icons (iOS) -->
<link rel="apple-touch-icon" href="/icons/apple/Icon-60@2x.png" sizes="120x120" />
<link rel="apple-touch-icon" href="/icons/apple/Icon-60@3x.png" sizes="180x180" />
<link rel="apple-touch-icon" href="/icons/apple/Icon-76.png" sizes="76x76" />
<link rel="apple-touch-icon" href="/icons/apple/Icon-76@2x.png" sizes="152x152" />
<link rel="apple-touch-icon" href="/icons/apple/Icon-83.5@2x.png" sizes="167x167" />

<!-- Standard Web App Icons -->
<link rel="icon" type="image/png" sizes="72x72" href="/icons/icon-72.png" />
<link rel="icon" type="image/png" sizes="96x96" href="/icons/icon-96.png" />
<link rel="icon" type="image/png" sizes="128x128" href="/icons/icon-128.png" />
<link rel="icon" type="image/png" sizes="192x192" href="/icons/icon-192.png" />
<link rel="icon" type="image/png" sizes="256x256" href="/icons/icon-256.png" />
<link rel="icon" type="image/png" sizes="384x384" href="/icons/icon-384.png" />
<link rel="icon" type="image/png" sizes="512x512" href="/icons/icon-512.png" />

<!-- iOS Web App Configuration -->
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="apple-mobile-web-app-title" content="$ProjectName" />

<!-- Android Web App Configuration -->
<meta name="application-name" content="$ProjectName" />
<link rel="shortcut icon" href="/favicon.ico" />

<!-- Theme & Startup Configuration -->
<meta name="theme-color" content="#000000" />
<meta name="msapplication-TileColor" content="#000000" />
<meta name="msapplication-TileImage" content="/icons/icon-144.png" />

===========================================

MANIFEST.JSON ICONS ARRAY:

Вставьте этот массив в "icons" в manifest.json:

"icons": [
  {
    "src": "/favicon.ico",
    "sizes": "32x32",
    "type": "image/x-icon"
  },
  {
    "src": "/icons/icon-72.png",
    "sizes": "72x72",
    "type": "image/png",
    "purpose": "any"
  },
  {
    "src": "/icons/icon-96.png",
    "sizes": "96x96",
    "type": "image/png",
    "purpose": "any"
  },
  {
    "src": "/icons/icon-128.png",
    "sizes": "128x128",
    "type": "image/png",
    "purpose": "any"
  },
  {
    "src": "/icons/icon-192.png",
    "sizes": "192x192",
    "type": "image/png",
    "purpose": "any"
  },
  {
    "src": "/icons/icon-192-maskable.png",
    "sizes": "192x192",
    "type": "image/png",
    "purpose": "maskable"
  },
  {
    "src": "/icons/icon-256.png",
    "sizes": "256x256",
    "type": "image/png",
    "purpose": "any"
  },
  {
    "src": "/icons/icon-384.png",
    "sizes": "384x384",
    "type": "image/png",
    "purpose": "any"
  },
  {
    "src": "/icons/icon-512.png",
    "sizes": "512x512",
    "type": "image/png",
    "purpose": "any"
  }
]

===========================================

СТРУКТУРА ПАПОК:

icons/
├── icon-72.png
├── icon-96.png
├── icon-128.png
├── icon-144.png
├── icon-192.png
├── icon-192-maskable.png
├── icon-256.png
├── icon-384.png
├── icon-512.png
├── apple/
│   ├── Icon-Small.png
│   ├── Icon-Small@2x.png
│   ├── Icon-Small@3x.png
│   ├── Icon-Small-40.png
│   ├── Icon-Small-40@2x.png
│   ├── Icon-Small-40@3x.png
│   ├── Icon-60@2x.png
│   ├── Icon-60@3x.png
│   ├── Icon-76.png
│   ├── Icon-76@2x.png
│   └── Icon-83.5@2x.png
└── android/
    ├── mipmap-ldpi/ic_launcher.png
    ├── mipmap-mdpi/ic_launcher.png
    ├── mipmap-hdpi/ic_launcher.png
    ├── mipmap-xhdpi/ic_launcher.png
    ├── mipmap-xxhdpi/ic_launcher.png
    └── mipmap-xxxhdpi/ic_launcher.png

===========================================
Generated: $(Get-Date -Format "dd.MM.yyyy HH:mm:ss")
"@

$htmlHeader | Out-File -FilePath $HeaderFile -Encoding UTF8
Write-Host "✓ HTML header создан: $HeaderFile" -ForegroundColor $SuccessColor

# ====== ИТОГИ ======
Write-Host "`n" -ForegroundColor $SuccessColor
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor $SuccessColor
Write-Host "║                    ✅ ГОТОВО!                                 ║" -ForegroundColor $SuccessColor
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor $SuccessColor

Write-Host "`n📁 Иконки сохранены в папку: $OutputDir" -ForegroundColor $InfoColor
Write-Host "📝 HTML header сохранен в: $HeaderFile" -ForegroundColor $InfoColor

Write-Host "`n📋 Статистика:" -ForegroundColor $InfoColor
Write-Host "   ✓ 9 веб иконок (72px до 512px)" -ForegroundColor $SuccessColor
Write-Host "   ✓ 11 Apple иконок для iOS" -ForegroundColor $SuccessColor
Write-Host "   ✓ 6 Android мипмапов" -ForegroundColor $SuccessColor
Write-Host "   ✓ 26 файлов создано" -ForegroundColor $SuccessColor

Write-Host "`n🚀 Далее:" -ForegroundColor $InfoColor
Write-Host "   1. Скопируйте папку 'icons' в 'public' вашего проекта" -ForegroundColor $InfoColor
Write-Host "   2. Откройте $HeaderFile и скопируйте HTML в index.html" -ForegroundColor $InfoColor
Write-Host "   3. Обновите manifest.json с иконками из $HeaderFile" -ForegroundColor $InfoColor
Write-Host "`n"
