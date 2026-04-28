@echo off
REM ====================================================================
REM PWA Icon Generator Script for Windows
REM Генератор иконок для всех платформ (iOS, Android, Web, PWA)
REM ====================================================================
REM 
REM Требования: ImageMagick должен быть установлен
REM Загрузить: https://imagemagick.org/script/download.php#windows
REM
REM Использование:
REM   1. Разместите иконку 512x512px в папке скрипта с именем "source-icon.png"
REM   2. Запустите: generate-icons.bat
REM   3. Дождитесь завершения
REM   4. Откройте header.txt и скопируйте готовый HTML
REM
REM ====================================================================

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║         PWA ICON GENERATOR v1.0                               ║
echo ║    Генератор иконок для iOS, Android, Web и PWA               ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM ====== КОНФИГУРАЦИЯ ======
set SOURCE_ICON=source-icon.png
set OUTPUT_DIR=icons
set HEADER_FILE=header.txt
set PROJECT_NAME=My App

REM ====== ПРОВЕРКА IMAGEMAGICK ======
where magick >nul 2>&1
if errorlevel 1 (
    echo ❌ ОШИБКА: ImageMagick не найден!
    echo.
    echo Пожалуйста установите ImageMagick:
    echo https://imagemagick.org/script/download.php#windows
    echo.
    echo После установки перезагрузите систему и запустите скрипт снова.
    pause
    exit /b 1
)

REM ====== ПРОВЕРКА ИСХОДНОЙ ИКОНКИ ======
if not exist "%SOURCE_ICON%" (
    echo ❌ ОШИБКА: Файл "%SOURCE_ICON%" не найден!
    echo.
    echo Пожалуйста разместите иконку 512x512px с именем "%SOURCE_ICON%" в папке скрипта.
    pause
    exit /b 1
)

echo ✓ Найдена исходная иконка: %SOURCE_ICON%
echo.

REM ====== СОЗДАНИЕ ДИРЕКТОРИЙ ======
echo 📁 Создаю директории...
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"
if not exist "%OUTPUT_DIR%\apple" mkdir "%OUTPUT_DIR%\apple"
if not exist "%OUTPUT_DIR%\android" mkdir "%OUTPUT_DIR%\android"
if not exist "%OUTPUT_DIR%\android\mipmap-ldpi" mkdir "%OUTPUT_DIR%\android\mipmap-ldpi"
if not exist "%OUTPUT_DIR%\android\mipmap-mdpi" mkdir "%OUTPUT_DIR%\android\mipmap-mdpi"
if not exist "%OUTPUT_DIR%\android\mipmap-hdpi" mkdir "%OUTPUT_DIR%\android\mipmap-hdpi"
if not exist "%OUTPUT_DIR%\android\mipmap-xhdpi" mkdir "%OUTPUT_DIR%\android\mipmap-xhdpi"
if not exist "%OUTPUT_DIR%\android\mipmap-xxhdpi" mkdir "%OUTPUT_DIR%\android\mipmap-xxhdpi"
if not exist "%OUTPUT_DIR%\android\mipmap-xxxhdpi" mkdir "%OUTPUT_DIR%\android\mipmap-xxxhdpi"
echo ✓ Директории созданы
echo.

REM ====== ГЕНЕРАЦИЯ ВЕБ ИКОНОК ======
echo 🌐 Генерирую веб иконки...

echo   ↳ icon-72.png (72x72)
magick "%SOURCE_ICON%" -resize 72x72 "%OUTPUT_DIR%\icon-72.png"

echo   ↳ icon-96.png (96x96)
magick "%SOURCE_ICON%" -resize 96x96 "%OUTPUT_DIR%\icon-96.png"

echo   ↳ icon-128.png (128x128)
magick "%SOURCE_ICON%" -resize 128x128 "%OUTPUT_DIR%\icon-128.png"

echo   ↳ icon-144.png (144x144 - Windows tiles)
magick "%SOURCE_ICON%" -resize 144x144 "%OUTPUT_DIR%\icon-144.png"

echo   ↳ icon-192.png (192x192 - Android)
magick "%SOURCE_ICON%" -resize 192x192 "%OUTPUT_DIR%\icon-192.png"

echo   ↳ icon-192-maskable.png (192x192 - PWA maskable)
magick "%SOURCE_ICON%" -resize 192x192 "%OUTPUT_DIR%\icon-192-maskable.png"

echo   ↳ icon-256.png (256x256)
magick "%SOURCE_ICON%" -resize 256x256 "%OUTPUT_DIR%\icon-256.png"

echo   ↳ icon-384.png (384x384)
magick "%SOURCE_ICON%" -resize 384x384 "%OUTPUT_DIR%\icon-384.png"

echo   ↳ icon-512.png (512x512 - PWA splash)
magick "%SOURCE_ICON%" -resize 512x512 "%OUTPUT_DIR%\icon-512.png"

echo ✓ Веб иконки готовы
echo.

REM ====== ГЕНЕРАЦИЯ APPLE ИКОНОК ======
echo 🍎 Генерирую Apple иконки (iOS)...

echo   ↳ Icon-Small.png (29x29)
magick "%SOURCE_ICON%" -resize 29x29 "%OUTPUT_DIR%\apple\Icon-Small.png"

echo   ↳ Icon-Small@2x.png (58x58)
magick "%SOURCE_ICON%" -resize 58x58 "%OUTPUT_DIR%\apple\Icon-Small@2x.png"

echo   ↳ Icon-Small@3x.png (87x87)
magick "%SOURCE_ICON%" -resize 87x87 "%OUTPUT_DIR%\apple\Icon-Small@3x.png"

echo   ↳ Icon-Small-40.png (40x40)
magick "%SOURCE_ICON%" -resize 40x40 "%OUTPUT_DIR%\apple\Icon-Small-40.png"

echo   ↳ Icon-Small-40@2x.png (80x80)
magick "%SOURCE_ICON%" -resize 80x80 "%OUTPUT_DIR%\apple\Icon-Small-40@2x.png"

echo   ↳ Icon-Small-40@3x.png (120x120)
magick "%SOURCE_ICON%" -resize 120x120 "%OUTPUT_DIR%\apple\Icon-Small-40@3x.png"

echo   ↳ Icon-60@2x.png (120x120)
magick "%SOURCE_ICON%" -resize 120x120 "%OUTPUT_DIR%\apple\Icon-60@2x.png"

echo   ↳ Icon-60@3x.png (180x180)
magick "%SOURCE_ICON%" -resize 180x180 "%OUTPUT_DIR%\apple\Icon-60@3x.png"

echo   ↳ Icon-76.png (76x76)
magick "%SOURCE_ICON%" -resize 76x76 "%OUTPUT_DIR%\apple\Icon-76.png"

echo   ↳ Icon-76@2x.png (152x152)
magick "%SOURCE_ICON%" -resize 152x152 "%OUTPUT_DIR%\apple\Icon-76@2x.png"

echo   ↳ Icon-83.5@2x.png (167x167)
magick "%SOURCE_ICON%" -resize 167x167 "%OUTPUT_DIR%\apple\Icon-83.5@2x.png"

echo ✓ Apple иконки готовы
echo.

REM ====== ГЕНЕРАЦИЯ ANDROID ИКОНОК ======
echo 🤖 Генерирую Android иконки (мипмапы)...

echo   ↳ mipmap-ldpi (36x36)
magick "%SOURCE_ICON%" -resize 36x36 "%OUTPUT_DIR%\android\mipmap-ldpi\ic_launcher.png"

echo   ↳ mipmap-mdpi (48x48)
magick "%SOURCE_ICON%" -resize 48x48 "%OUTPUT_DIR%\android\mipmap-mdpi\ic_launcher.png"

echo   ↳ mipmap-hdpi (72x72)
magick "%SOURCE_ICON%" -resize 72x72 "%OUTPUT_DIR%\android\mipmap-hdpi\ic_launcher.png"

echo   ↳ mipmap-xhdpi (96x96)
magick "%SOURCE_ICON%" -resize 96x96 "%OUTPUT_DIR%\android\mipmap-xhdpi\ic_launcher.png"

echo   ↳ mipmap-xxhdpi (144x144)
magick "%SOURCE_ICON%" -resize 144x144 "%OUTPUT_DIR%\android\mipmap-xxhdpi\ic_launcher.png"

echo   ↳ mipmap-xxxhdpi (192x192)
magick "%SOURCE_ICON%" -resize 192x192 "%OUTPUT_DIR%\android\mipmap-xxxhdpi\ic_launcher.png"

echo ✓ Android иконки готовы
echo.

REM ====== ГЕНЕРАЦИЯ HTML HEADER ======
echo 📝 Генерирую HTML header...

(
echo # HTML HEADER ДЛЯ СКОПИРОВАНИЯ В index.html
echo.
echo ## СКОПИРУЙТЕ БЕЗ ЭТИХ КОММЕНТАРИЕВ:
echo.
echo Favicon ^& Icons ^(вставьте в ^<head^>^):
echo.
echo ^<!-- Favicon ^--^>
echo ^<link rel="icon" type="image/x-icon" href="/favicon.ico" /^>
echo.
echo ^<!-- Apple Touch Icons (iOS) ^--^>
echo ^<link rel="apple-touch-icon" href="/icons/apple/Icon-60@2x.png" sizes="120x120" /^>
echo ^<link rel="apple-touch-icon" href="/icons/apple/Icon-60@3x.png" sizes="180x180" /^>
echo ^<link rel="apple-touch-icon" href="/icons/apple/Icon-76.png" sizes="76x76" /^>
echo ^<link rel="apple-touch-icon" href="/icons/apple/Icon-76@2x.png" sizes="152x152" /^>
echo ^<link rel="apple-touch-icon" href="/icons/apple/Icon-83.5@2x.png" sizes="167x167" /^>
echo.
echo ^<!-- Standard Web App Icons ^--^>
echo ^<link rel="icon" type="image/png" sizes="72x72" href="/icons/icon-72.png" /^>
echo ^<link rel="icon" type="image/png" sizes="96x96" href="/icons/icon-96.png" /^>
echo ^<link rel="icon" type="image/png" sizes="128x128" href="/icons/icon-128.png" /^>
echo ^<link rel="icon" type="image/png" sizes="192x192" href="/icons/icon-192.png" /^>
echo ^<link rel="icon" type="image/png" sizes="256x256" href="/icons/icon-256.png" /^>
echo ^<link rel="icon" type="image/png" sizes="384x384" href="/icons/icon-384.png" /^>
echo ^<link rel="icon" type="image/png" sizes="512x512" href="/icons/icon-512.png" /^>
echo.
echo ^<!-- iOS Web App Configuration ^--^>
echo ^<meta name="apple-mobile-web-app-capable" content="yes" /^>
echo ^<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" /^>
echo ^<meta name="apple-mobile-web-app-title" content="%PROJECT_NAME%" /^>
echo.
echo ^<!-- Android Web App Configuration ^--^>
echo ^<meta name="application-name" content="%PROJECT_NAME%" /^>
echo ^<link rel="shortcut icon" href="/favicon.ico" /^>
echo.
echo ^<!-- Theme ^& Startup Configuration ^--^>
echo ^<meta name="theme-color" content="#000000" /^>
echo ^<meta name="msapplication-TileColor" content="#000000" /^>
echo ^<meta name="msapplication-TileImage" content="/icons/icon-144.png" /^>
echo.
echo ===========================================
echo.
echo MANIFEST.JSON ICONS ARRAY:
echo.
echo Вставьте этот массив в "icons" в manifest.json:
echo.
echo "icons": [
echo   {
echo     "src": "/favicon.ico",
echo     "sizes": "32x32",
echo     "type": "image/x-icon"
echo   },
echo   {
echo     "src": "/icons/icon-72.png",
echo     "sizes": "72x72",
echo     "type": "image/png",
echo     "purpose": "any"
echo   },
echo   {
echo     "src": "/icons/icon-96.png",
echo     "sizes": "96x96",
echo     "type": "image/png",
echo     "purpose": "any"
echo   },
echo   {
echo     "src": "/icons/icon-128.png",
echo     "sizes": "128x128",
echo     "type": "image/png",
echo     "purpose": "any"
echo   },
echo   {
echo     "src": "/icons/icon-192.png",
echo     "sizes": "192x192",
echo     "type": "image/png",
echo     "purpose": "any"
echo   },
echo   {
echo     "src": "/icons/icon-192-maskable.png",
echo     "sizes": "192x192",
echo     "type": "image/png",
echo     "purpose": "maskable"
echo   },
echo   {
echo     "src": "/icons/icon-256.png",
echo     "sizes": "256x256",
echo     "type": "image/png",
echo     "purpose": "any"
echo   },
echo   {
echo     "src": "/icons/icon-384.png",
echo     "sizes": "384x384",
echo     "type": "image/png",
echo     "purpose": "any"
echo   },
echo   {
echo     "src": "/icons/icon-512.png",
echo     "sizes": "512x512",
echo     "type": "image/png",
echo     "purpose": "any"
echo   }
echo ]
echo.
echo ===========================================
echo.
echo СТРУКТУРА ПАПОК:
echo.
echo icons/
echo ├── icon-72.png
echo ├── icon-96.png
echo ├── icon-128.png
echo ├── icon-144.png
echo ├── icon-192.png
echo ├── icon-192-maskable.png
echo ├── icon-256.png
echo ├── icon-384.png
echo ├── icon-512.png
echo ├── apple/
echo │   ├── Icon-Small.png
echo │   ├── Icon-Small@2x.png
echo │   ├── Icon-Small@3x.png
echo │   ├── Icon-Small-40.png
echo │   ├── Icon-Small-40@2x.png
echo │   ├── Icon-Small-40@3x.png
echo │   ├── Icon-60@2x.png
echo │   ├── Icon-60@3x.png
echo │   ├── Icon-76.png
echo │   ├── Icon-76@2x.png
echo │   └── Icon-83.5@2x.png
echo └── android/
echo     ├── mipmap-ldpi/ic_launcher.png
echo     ├── mipmap-mdpi/ic_launcher.png
echo     ├── mipmap-hdpi/ic_launcher.png
echo     ├── mipmap-xhdpi/ic_launcher.png
echo     ├── mipmap-xxhdpi/ic_launcher.png
echo     └── mipmap-xxxhdpi/ic_launcher.png
echo.
echo ===========================================
echo Generated: %DATE% %TIME%
) > "%HEADER_FILE%"

echo ✓ HTML header создан: %HEADER_FILE%
echo.

REM ====== ИТОГИ ======
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                    ✅ ГОТОВО!                                 ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo 📁 Иконки сохранены в папку: %OUTPUT_DIR%
echo 📝 HTML header сохранен в: %HEADER_FILE%
echo.
echo 📋 Статистика:
echo    ✓ 9 веб иконок (72px до 512px)
echo    ✓ 11 Apple иконок для iOS
echo    ✓ 6 Android мипмапов
echo    ✓ 26 файлов создано
echo.
echo 🚀 Далее:
echo    1. Скопируйте всю папку "%OUTPUT_DIR%" в папку вашего проекта
echo    2. Откройте файл "%HEADER_FILE%" и скопируйте HTML в index.html
echo    3. Если используете Vite, убедитесь что publicDir = "public"
echo    4. Запустите: npm run build
echo.
echo 🔗 Справка:
echo    - Web иконки должны быть в public/icons/
echo    - Apple иконки в public/icons/apple/
echo    - Android иконки в public/icons/android/mipmap-*/
echo    - favicon.ico должен быть в public/
echo.
pause
