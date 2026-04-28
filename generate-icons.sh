#!/bin/bash

# ====================================================================
# PWA Icon Generator Script for Linux/Mac (Bash)
# Генератор иконок для всех платформ (iOS, Android, Web, PWA)
# ====================================================================
#
# Требования: ImageMagick должен быть установлен
# 
# Mac: brew install imagemagick
# Linux: sudo apt-get install imagemagick
#
# Использование:
#   1. Разместите иконку 512x512px в папке скрипта с именем "source-icon.png"
#   2. Запустите: chmod +x generate-icons.sh && ./generate-icons.sh
#   3. Дождитесь завершения
#   4. Откройте header.txt и скопируйте готовый HTML
#
# ====================================================================

set -e

# ====== КОНФИГУРАЦИЯ ======
SOURCE_ICON="source-icon.png"
OUTPUT_DIR="icons"
HEADER_FILE="header.txt"
PROJECT_NAME="My App"

# ====== ЦВЕТА ======
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ====== ФУНКЦИИ ======
print_header() {
    echo -e "\n${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║         PWA ICON GENERATOR v1.0 (Bash)                        ║${NC}"
    echo -e "${CYAN}║    Генератор иконок для iOS, Android, Web и PWA               ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}❌ ОШИБКА:${NC} $1"
}

print_info() {
    echo -e "${CYAN}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

# ====== ПРОВЕРКА IMAGEMAGICK ======
print_info "🔍 Проверяю ImageMagick..."

if ! command -v convert &> /dev/null; then
    print_error "ImageMagick не найден!"
    echo ""
    print_warning "Пожалуйста установите ImageMagick:"
    echo ""
    echo "На Mac: brew install imagemagick"
    echo "На Linux: sudo apt-get install imagemagick"
    echo "На CentOS: sudo yum install ImageMagick"
    echo ""
    exit 1
fi

MAGICK_VERSION=$(convert --version | head -1)
print_success "ImageMagick найден: $MAGICK_VERSION"

# ====== ПРОВЕРКА ИСХОДНОЙ ИКОНКИ ======
echo ""
print_info "🔍 Проверяю исходную иконку..."

if [ ! -f "$SOURCE_ICON" ]; then
    print_error "Файл '$SOURCE_ICON' не найден!"
    echo ""
    print_warning "Пожалуйста разместите иконку 512x512px с именем '$SOURCE_ICON' в папке скрипта."
    exit 1
fi

print_success "Найдена исходная иконка: $SOURCE_ICON"

# ====== СОЗДАНИЕ ДИРЕКТОРИЙ ======
echo ""
print_info "📁 Создаю директории..."

mkdir -p "$OUTPUT_DIR/apple"
mkdir -p "$OUTPUT_DIR/android/mipmap-ldpi"
mkdir -p "$OUTPUT_DIR/android/mipmap-mdpi"
mkdir -p "$OUTPUT_DIR/android/mipmap-hdpi"
mkdir -p "$OUTPUT_DIR/android/mipmap-xhdpi"
mkdir -p "$OUTPUT_DIR/android/mipmap-xxhdpi"
mkdir -p "$OUTPUT_DIR/android/mipmap-xxxhdpi"

print_success "Директории созданы"

# ====== ФУНКЦИЯ ДЛЯ ГЕНЕРАЦИИ ИКОНОК ======
generate_icon() {
    local output_path=$1
    local size=$2
    local label=$3
    
    echo -e "   ${CYAN}↳${NC} $label ($size x $size)"
    convert "$SOURCE_ICON" -resize "${size}x${size}" "$output_path"
    print_success "     Сохранено"
}

# ====== ГЕНЕРАЦИЯ ВЕБ ИКОНОК ======
echo ""
print_info "🌐 Генерирую веб иконки..."
generate_icon "$OUTPUT_DIR/icon-72.png" 72 "icon-72.png"
generate_icon "$OUTPUT_DIR/icon-96.png" 96 "icon-96.png"
generate_icon "$OUTPUT_DIR/icon-128.png" 128 "icon-128.png"
generate_icon "$OUTPUT_DIR/icon-144.png" 144 "icon-144.png (Windows tiles)"
generate_icon "$OUTPUT_DIR/icon-192.png" 192 "icon-192.png (Android)"
generate_icon "$OUTPUT_DIR/icon-192-maskable.png" 192 "icon-192-maskable.png (PWA)"
generate_icon "$OUTPUT_DIR/icon-256.png" 256 "icon-256.png"
generate_icon "$OUTPUT_DIR/icon-384.png" 384 "icon-384.png"
generate_icon "$OUTPUT_DIR/icon-512.png" 512 "icon-512.png (PWA splash)"

# ====== ГЕНЕРАЦИЯ APPLE ИКОНОК ======
echo ""
print_info "🍎 Генерирую Apple иконки (iOS)..."
generate_icon "$OUTPUT_DIR/apple/Icon-Small.png" 29 "Icon-Small.png"
generate_icon "$OUTPUT_DIR/apple/Icon-Small@2x.png" 58 "Icon-Small@2x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-Small@3x.png" 87 "Icon-Small@3x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-Small-40.png" 40 "Icon-Small-40.png"
generate_icon "$OUTPUT_DIR/apple/Icon-Small-40@2x.png" 80 "Icon-Small-40@2x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-Small-40@3x.png" 120 "Icon-Small-40@3x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-60@2x.png" 120 "Icon-60@2x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-60@3x.png" 180 "Icon-60@3x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-76.png" 76 "Icon-76.png"
generate_icon "$OUTPUT_DIR/apple/Icon-76@2x.png" 152 "Icon-76@2x.png"
generate_icon "$OUTPUT_DIR/apple/Icon-83.5@2x.png" 167 "Icon-83.5@2x.png"

# ====== ГЕНЕРАЦИЯ ANDROID ИКОНОК ======
echo ""
print_info "🤖 Генерирую Android иконки (мипмапы)..."
generate_icon "$OUTPUT_DIR/android/mipmap-ldpi/ic_launcher.png" 36 "mipmap-ldpi"
generate_icon "$OUTPUT_DIR/android/mipmap-mdpi/ic_launcher.png" 48 "mipmap-mdpi"
generate_icon "$OUTPUT_DIR/android/mipmap-hdpi/ic_launcher.png" 72 "mipmap-hdpi"
generate_icon "$OUTPUT_DIR/android/mipmap-xhdpi/ic_launcher.png" 96 "mipmap-xhdpi"
generate_icon "$OUTPUT_DIR/android/mipmap-xxhdpi/ic_launcher.png" 144 "mipmap-xxhdpi"
generate_icon "$OUTPUT_DIR/android/mipmap-xxxhdpi/ic_launcher.png" 192 "mipmap-xxxhdpi"

# ====== ГЕНЕРАЦИЯ HTML HEADER ======
echo ""
print_info "📝 Генерирую HTML header..."

cat > "$HEADER_FILE" << 'EOF'
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
<meta name="apple-mobile-web-app-title" content="My App" />

<!-- Android Web App Configuration -->
<meta name="application-name" content="My App" />
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
Generated: $(date)
EOF

print_success "HTML header создан: $HEADER_FILE"

# ====== ИТОГИ ======
echo ""
print_info "╔════════════════════════════════════════════════════════════════╗"
print_info "║                    ✅ ГОТОВО!                                 ║"
print_info "╚════════════════════════════════════════════════════════════════╝"

echo ""
echo "📁 Иконки сохранены в папку: $OUTPUT_DIR"
echo "📝 HTML header сохранен в: $HEADER_FILE"

echo ""
print_info "📋 Статистика:"
print_success "   9 веб иконок (72px до 512px)"
print_success "   11 Apple иконок для iOS"
print_success "   6 Android мипмапов"
print_success "   26 файлов создано"

echo ""
print_info "🚀 Далее:"
echo "   1. Скопируйте всю папку '$OUTPUT_DIR' в папку 'public' вашего проекта"
echo "   2. Откройте файл '$HEADER_FILE' и скопируйте HTML в index.html"
echo "   3. Если используете Vite, убедитесь что publicDir = \"public\""
echo "   4. Запустите: npm run build"

echo ""
print_info "🔗 Справка:"
echo "   - Web иконки должны быть в public/icons/"
echo "   - Apple иконки в public/icons/apple/"
echo "   - Android иконки в public/icons/android/mipmap-*/"
echo "   - favicon.ico должен быть в public/"

echo ""
