# 🎬 FFmpeg Команды для Генерации Иконок

## Альтернатива ImageMagick — используем FFmpeg

FFmpeg можно использовать вместо ImageMagick для быстрого масштабирования иконок.

### Требования
```bash
# Windows (через chocolatey или winget)
winget install ffmpeg

# Mac
brew install ffmpeg

# Linux
sudo apt-get install ffmpeg
```

---

## 1️⃣ Базовые команды для каждого размера

### Веб иконки (отдельно)
```bash
# 72x72
ffmpeg -i source-icon.png -vf scale=72:72 icons/icon-72.png

# 96x96
ffmpeg -i source-icon.png -vf scale=96:96 icons/icon-96.png

# 128x128
ffmpeg -i source-icon.png -vf scale=128:128 icons/icon-128.png

# 144x144
ffmpeg -i source-icon.png -vf scale=144:144 icons/icon-144.png

# 192x192
ffmpeg -i source-icon.png -vf scale=192:192 icons/icon-192.png

# 256x256
ffmpeg -i source-icon.png -vf scale=256:256 icons/icon-256.png

# 384x384
ffmpeg -i source-icon.png -vf scale=384:384 icons/icon-384.png

# 512x512
ffmpeg -i source-icon.png -vf scale=512:512 icons/icon-512.png
```

---

## 2️⃣ Пакетная генерация (один батник)

### `generate-icons-ffmpeg.bat`
```batch
@echo off
setlocal enabledelayedexpansion

set SOURCE_ICON=source-icon.png
set OUTPUT_DIR=icons

echo Generating web icons...
ffmpeg -i %SOURCE_ICON% -vf scale=72:72 %OUTPUT_DIR%\icon-72.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=96:96 %OUTPUT_DIR%\icon-96.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=128:128 %OUTPUT_DIR%\icon-128.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=144:144 %OUTPUT_DIR%\icon-144.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=192:192 %OUTPUT_DIR%\icon-192.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=256:256 %OUTPUT_DIR%\icon-256.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=384:384 %OUTPUT_DIR%\icon-384.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=512:512 %OUTPUT_DIR%\icon-512.png -y

echo Generating Apple icons...
ffmpeg -i %SOURCE_ICON% -vf scale=29:29 %OUTPUT_DIR%\apple\Icon-Small.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=58:58 %OUTPUT_DIR%\apple\Icon-Small@2x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=87:87 %OUTPUT_DIR%\apple\Icon-Small@3x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=40:40 %OUTPUT_DIR%\apple\Icon-Small-40.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=80:80 %OUTPUT_DIR%\apple\Icon-Small-40@2x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=120:120 %OUTPUT_DIR%\apple\Icon-Small-40@3x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=120:120 %OUTPUT_DIR%\apple\Icon-60@2x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=180:180 %OUTPUT_DIR%\apple\Icon-60@3x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=76:76 %OUTPUT_DIR%\apple\Icon-76.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=152:152 %OUTPUT_DIR%\apple\Icon-76@2x.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=167:167 %OUTPUT_DIR%\apple\Icon-83.5@2x.png -y

echo Generating Android icons...
ffmpeg -i %SOURCE_ICON% -vf scale=36:36 %OUTPUT_DIR%\android\mipmap-ldpi\ic_launcher.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=48:48 %OUTPUT_DIR%\android\mipmap-mdpi\ic_launcher.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=72:72 %OUTPUT_DIR%\android\mipmap-hdpi\ic_launcher.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=96:96 %OUTPUT_DIR%\android\mipmap-xhdpi\ic_launcher.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=144:144 %OUTPUT_DIR%\android\mipmap-xxhdpi\ic_launcher.png -y
ffmpeg -i %SOURCE_ICON% -vf scale=192:192 %OUTPUT_DIR%\android\mipmap-xxxhdpi\ic_launcher.png -y

echo Done!
pause
```

---

## 3️⃣ PowerShell версия (cross-platform)

### `generate-icons-ffmpeg.ps1`
```powershell
param(
    [string]$SourceIcon = "source-icon.png",
    [string]$OutputDir = "icons"
)

# Проверка ffmpeg
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "FFmpeg не найден! Установите ffmpeg и попробуйте снова." -ForegroundColor Red
    exit 1
}

# Веб иконки
$webSizes = @(
    @{size = 72; name = "icon-72.png"},
    @{size = 96; name = "icon-96.png"},
    @{size = 128; name = "icon-128.png"},
    @{size = 144; name = "icon-144.png"},
    @{size = 192; name = "icon-192.png"},
    @{size = 256; name = "icon-256.png"},
    @{size = 384; name = "icon-384.png"},
    @{size = 512; name = "icon-512.png"}
)

foreach ($icon in $webSizes) {
    $output = Join-Path $OutputDir $icon.name
    Write-Host "Generating $($icon.name)..." -ForegroundColor Cyan
    & ffmpeg -i $SourceIcon -vf "scale=$($icon.size):$($icon.size)" "$output" -y 2>$null
}

# Apple иконки
$appleSizes = @(
    @{size = 29; name = "Icon-Small.png"},
    @{size = 58; name = "Icon-Small@2x.png"},
    @{size = 87; name = "Icon-Small@3x.png"},
    @{size = 40; name = "Icon-Small-40.png"},
    @{size = 80; name = "Icon-Small-40@2x.png"},
    @{size = 120; name = "Icon-Small-40@3x.png"},
    @{size = 120; name = "Icon-60@2x.png"},
    @{size = 180; name = "Icon-60@3x.png"},
    @{size = 76; name = "Icon-76.png"},
    @{size = 152; name = "Icon-76@2x.png"},
    @{size = 167; name = "Icon-83.5@2x.png"}
)

foreach ($icon in $appleSizes) {
    $output = Join-Path $OutputDir "apple" $icon.name
    Write-Host "Generating Apple $($icon.name)..." -ForegroundColor Cyan
    & ffmpeg -i $SourceIcon -vf "scale=$($icon.size):$($icon.size)" "$output" -y 2>$null
}

Write-Host "Done!" -ForegroundColor Green
```

---

## 4️⃣ Bash версия (Mac/Linux)

### `generate-icons-ffmpeg.sh`
```bash
#!/bin/bash

SOURCE_ICON="source-icon.png"
OUTPUT_DIR="icons"

# Проверка ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg не найден! Установите ffmpeg и попробуйте снова."
    exit 1
fi

# Веб иконки
echo "Generating web icons..."
ffmpeg -i "$SOURCE_ICON" -vf scale=72:72 "$OUTPUT_DIR/icon-72.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=96:96 "$OUTPUT_DIR/icon-96.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=128:128 "$OUTPUT_DIR/icon-128.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=144:144 "$OUTPUT_DIR/icon-144.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=192:192 "$OUTPUT_DIR/icon-192.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=256:256 "$OUTPUT_DIR/icon-256.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=384:384 "$OUTPUT_DIR/icon-384.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=512:512 "$OUTPUT_DIR/icon-512.png" -y

# Apple иконки
echo "Generating Apple icons..."
ffmpeg -i "$SOURCE_ICON" -vf scale=29:29 "$OUTPUT_DIR/apple/Icon-Small.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=58:58 "$OUTPUT_DIR/apple/Icon-Small@2x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=87:87 "$OUTPUT_DIR/apple/Icon-Small@3x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=40:40 "$OUTPUT_DIR/apple/Icon-Small-40.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=80:80 "$OUTPUT_DIR/apple/Icon-Small-40@2x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=120:120 "$OUTPUT_DIR/apple/Icon-Small-40@3x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=120:120 "$OUTPUT_DIR/apple/Icon-60@2x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=180:180 "$OUTPUT_DIR/apple/Icon-60@3x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=76:76 "$OUTPUT_DIR/apple/Icon-76.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=152:152 "$OUTPUT_DIR/apple/Icon-76@2x.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=167:167 "$OUTPUT_DIR/apple/Icon-83.5@2x.png" -y

# Android иконки
echo "Generating Android icons..."
ffmpeg -i "$SOURCE_ICON" -vf scale=36:36 "$OUTPUT_DIR/android/mipmap-ldpi/ic_launcher.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=48:48 "$OUTPUT_DIR/android/mipmap-mdpi/ic_launcher.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=72:72 "$OUTPUT_DIR/android/mipmap-hdpi/ic_launcher.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=96:96 "$OUTPUT_DIR/android/mipmap-xhdpi/ic_launcher.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=144:144 "$OUTPUT_DIR/android/mipmap-xxhdpi/ic_launcher.png" -y
ffmpeg -i "$SOURCE_ICON" -vf scale=192:192 "$OUTPUT_DIR/android/mipmap-xxxhdpi/ic_launcher.png" -y

echo "Done!"
```

---

## 5️⃣ Одна команда (все размеры сразу) — Advanced FFmpeg

```bash
# Для продвинутых пользователей — создание всех размеров за один проход
# Используется format filter для параллельной генерации

ffmpeg -i source-icon.png \
  -vf "scale=72:72" icons/icon-72.png \
  -vf "scale=96:96" icons/icon-96.png \
  -vf "scale=192:192" icons/icon-192.png \
  -vf "scale=512:512" icons/icon-512.png \
  -y
```

---

## 6️⃣ Comparison: ImageMagick vs FFmpeg

| Параметр | ImageMagick | FFmpeg |
|----------|-------------|--------|
| **Размер установки** | ~40 MB | ~60 MB |
| **Скорость** | Средняя | Быстрая |
| **Функциональность** | Узконаправленная | Универсальная |
| **Качество масштабирования** | Отличное | Отличное |
| **Кроссплатформность** | Да | Да |
| **Удобство** | Проще на Windows | Проще на Linux/Mac |

---

## 💡 Pro Tips

### Без подтверждений (быстрее)
```bash
ffmpeg -i source-icon.png -vf scale=192:192 output.png -y
# -y = автоматически перезаписывает файлы
```

### С прогрессом (подробнее)
```bash
ffmpeg -i source-icon.png -vf scale=192:192 output.png -progress pipe:1
```

### Оптимизация качества
```bash
# Качество по умолчанию
ffmpeg -i source-icon.png -vf scale=192:192 output.png

# С более хорошей интерполяцией
ffmpeg -i source-icon.png -vf "scale=192:192:flags=lanczos" output.png

# С шарпнингом для четкости
ffmpeg -i source-icon.png -vf "scale=192:192,unsharp=1.0:1.0:1.5:0.05" output.png
```

---

## Использование

1. Выберите скрипт для вашей ОС
2. Положите `source-icon.png` в папку со скриптом
3. Запустите скрипт
4. Готово! Иконки в папке `icons/`
