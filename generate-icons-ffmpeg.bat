@echo off
REM ====================================================================
REM PWA Icon Generator Script for Windows (FFmpeg)
REM Генератор иконок для всех платформ (iOS, Android, Web, PWA)
REM ====================================================================
REM 
REM Требования: FFmpeg должен быть установлен
REM Загрузить: https://ffmpeg.org/download.html
REM Или через winget: winget install ffmpeg
REM
REM Использование:
REM   1. Разместите иконку 512x512px в папке скрипта с именем "source-icon.png"
REM   2. Запустите: generate-icons-ffmpeg.bat
REM   3. Дождитесь завершения
REM   4. Откройте header.txt и скопируйте готовый HTML
REM
REM ====================================================================

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║         PWA ICON GENERATOR v1.0 (FFmpeg)                      ║
echo ║    Генератор иконок для iOS, Android, Web и PWA               ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM ====== КОНФИГУРАЦИЯ ======
set SOURCE_ICON=source-icon.png
set OUTPUT_DIR=icons
set HEADER_FILE=header.txt
set PROJECT_NAME=My App

REM ====== ПРОВЕРКА FFMPEG ======
where ffmpeg >nul 2>&1
if errorlevel 1 (
    echo ❌ ОШИБКА: FFmpeg не найден!
    echo.
    echo Пожалуйста установите FFmpeg:
    echo https://ffmpeg.org/download.html
    echo.
    echo Или через winget:
    echo winget install ffmpeg
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
ffmpeg -i "%SOURCE_ICON%" -vf scale=72:72 "%OUTPUT_DIR%\icon-72.png" -y 2>nul

echo   ↳ icon-96.png (96x96)
ffmpeg -i "%SOURCE_ICON%" -vf scale=96:96 "%OUTPUT_DIR%\icon-96.png" -y 2>nul

echo   ↳ icon-128.png (128x128)
ffmpeg -i "%SOURCE_ICON%" -vf scale=128:128 "%OUTPUT_DIR%\icon-128.png" -y 2>nul

echo   ↳ icon-144.png (144x144 - Windows tiles)
ffmpeg -i "%SOURCE_ICON%" -vf scale=144:144 "%OUTPUT_DIR%\icon-144.png" -y 2>nul

echo   ↳ icon-192.png (192x192 - Android)
ffmpeg -i "%SOURCE_ICON%" -vf scale=192:192 "%OUTPUT_DIR%\icon-192.png" -y 2>nul

echo   ↳ icon-192-maskable.png (192x192 - PWA maskable)
ffmpeg -i "%SOURCE_ICON%" -vf scale=192:192 "%OUTPUT_DIR%\icon-192-maskable.png" -y 2>nul

echo   ↳ icon-256.png (256x256)
ffmpeg -i "%SOURCE_ICON%" -vf scale=256:256 "%OUTPUT_DIR%\icon-256.png" -y 2>nul

echo   ↳ icon-384.png (384x384)
ffmpeg -i "%SOURCE_ICON%" -vf scale=384:384 "%OUTPUT_DIR%\icon-384.png" -y 2>nul

echo   ↳ icon-512.png (512x512 - PWA splash)
ffmpeg -i "%SOURCE_ICON%" -vf scale=512:512 "%OUTPUT_DIR%\icon-512.png" -y 2>nul

echo ✓ Веб иконки готовы
echo.

REM ====== ГЕНЕРАЦИЯ APPLE ИКОНОК ======
echo 🍎 Генерирую Apple иконки (iOS)...

echo   ↳ Icon-Small.png (29x29)
ffmpeg -i "%SOURCE_ICON%" -vf scale=29:29 "%OUTPUT_DIR%\apple\Icon-Small.png" -y 2>nul

echo   ↳ Icon-Small@2x.png (58x58)
ffmpeg -i "%SOURCE_ICON%" -vf scale=58:58 "%OUTPUT_DIR%\apple\Icon-Small@2x.png" -y 2>nul

echo   ↳ Icon-Small@3x.png (87x87)
ffmpeg -i "%SOURCE_ICON%" -vf scale=87:87 "%OUTPUT_DIR%\apple\Icon-Small@3x.png" -y 2>nul

echo   ↳ Icon-Small-40.png (40x40)
ffmpeg -i "%SOURCE_ICON%" -vf scale=40:40 "%OUTPUT_DIR%\apple\Icon-Small-40.png" -y 2>nul

echo   ↳ Icon-Small-40@2x.png (80x80)
ffmpeg -i "%SOURCE_ICON%" -vf scale=80:80 "%OUTPUT_DIR%\apple\Icon-Small-40@2x.png" -y 2>nul

echo   ↳ Icon-Small-40@3x.png (120x120)
ffmpeg -i "%SOURCE_ICON%" -vf scale=120:120 "%OUTPUT_DIR%\apple\Icon-Small-40@3x.png" -y 2>nul

echo   ↳ Icon-60@2x.png (120x120)
ffmpeg -i "%SOURCE_ICON%" -vf scale=120:120 "%OUTPUT_DIR%\apple\Icon-60@2x.png" -y 2>nul

echo   ↳ Icon-60@3x.png (180x180)
ffmpeg -i "%SOURCE_ICON%" -vf scale=180:180 "%OUTPUT_DIR%\apple\Icon-60@3x.png" -y 2>nul

echo   ↳ Icon-76.png (76x76)
ffmpeg -i "%SOURCE_ICON%" -vf scale=76:76 "%OUTPUT_DIR%\apple\Icon-76.png" -y 2>nul

echo   ↳ Icon-76@2x.png (152x152)
ffmpeg -i "%SOURCE_ICON%" -vf scale=152:152 "%OUTPUT_DIR%\apple\Icon-76@2x.png" -y 2>nul

echo   ↳ Icon-83.5@2x.png (167x167)
ffmpeg -i "%SOURCE_ICON%" -vf scale=167:167 "%OUTPUT_DIR%\apple\Icon-83.5@2x.png" -y 2>nul

echo ✓ Apple иконки готовы
echo.

REM ====== ГЕНЕРАЦИЯ ANDROID ИКОНОК ======
echo 🤖 Генерирую Android иконки (мипмапы)...

echo   ↳ mipmap-ldpi (36x36)
ffmpeg -i "%SOURCE_ICON%" -vf scale=36:36 "%OUTPUT_DIR%\android\mipmap-ldpi\ic_launcher.png" -y 2>nul

echo   ↳ mipmap-mdpi (48x48)
ffmpeg -i "%SOURCE_ICON%" -vf scale=48:48 "%OUTPUT_DIR%\android\mipmap-mdpi\ic_launcher.png" -y 2>nul

echo   ↳ mipmap-hdpi (72x72)
ffmpeg -i "%SOURCE_ICON%" -vf scale=72:72 "%OUTPUT_DIR%\android\mipmap-hdpi\ic_launcher.png" -y 2>nul

echo   ↳ mipmap-xhdpi (96x96)
ffmpeg -i "%SOURCE_ICON%" -vf scale=96:96 "%OUTPUT_DIR%\android\mipmap-xhdpi\ic_launcher.png" -y 2>nul

echo   ↳ mipmap-xxhdpi (144x144)
ffmpeg -i "%SOURCE_ICON%" -vf scale=144:144 "%OUTPUT_DIR%\android\mipmap-xxhdpi\ic_launcher.png" -y 2>nul

echo   ↳ mipmap-xxxhdpi (192x192)
ffmpeg -i "%SOURCE_ICON%" -vf scale=192:192 "%OUTPUT_DIR%\android\mipmap-xxxhdpi\ic_launcher.png" -y 2>nul

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
) >> "%HEADER_FILE%"

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
echo    1. Скопируйте папку 'icons' в 'public' вашего проекта
echo    2. Откройте %HEADER_FILE% и скопируйте HTML в index.html
echo    3. Обновите manifest.json с иконками из %HEADER_FILE%
echo.

pause
