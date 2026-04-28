# 🎨 Icon Generator Scripts

Автоматический генератор иконок для PWA приложений. Один батник/скрипт разбивает одну 512x512 иконку на все необходимые размеры для iOS, Android, Web и PWA.

## 📋 Что генерируется?

### Веб иконки (9 размеров)
- 72×72, 96×96, 128×128, 144×144, 192×192, 192×192 (maskable), 256×256, 384×384, 512×512

### Apple иконки (11 иконок)
- Для iPhone, iPad, Spotlight, Settings приложения
- Все необходимые @1x, @2x, @3x версии

### Android иконки (6 плотностей)
- ldpi, mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi мипмапы
- Для всех плотностей экрана

### Бонус
- **header.txt** — готовый HTML для копирования в index.html
- **manifest.json массив** — готовый код для manifest.json

## 🚀 Быстрый старт

### Вариант 1️⃣: ImageMagick (Рекомендуется)

#### Шаг 1: Установка ImageMagick

**Windows:**
1. Скачайте с https://imagemagick.org/script/download.php#windows
2. Выберите "Windows x64 Dynamic at 16 bit-depth" (большой файл, но полнофункциональный)
3. Установите с галочкой "Install development headers and libraries"
4. Перезагрузитесь

**macOS:**
```bash
brew install imagemagick
```

**Linux:**
```bash
sudo apt-get install imagemagick
```

---

### Вариант 2️⃣: FFmpeg (Альтернатива)

**Windows (через winget):**
```bash
winget install ffmpeg
```

**macOS:**
```bash
brew install ffmpeg
```

**Linux:**
```bash
sudo apt-get install ffmpeg
```

➡️ **Подробные FFmpeg команды:** смотрите [ffmpeg-commands.md](ffmpeg-commands.md)

---

### Шаг 2: Подготовка иконки

1. Создайте иконку размером **512×512px** в формате **PNG**
2. Назовите её `source-icon.png`
3. Разместите в папке со скриптом

### Шаг 3: Запуск генератора

#### 🖼️ ImageMagick вариант:

**На Windows (Batch):**
```bash
# Откройте PowerShell в папке скрипта и запустите:
.\generate-icons.bat
```

**Или PowerShell версия (для Windows/Mac/Linux):**
```bash
.\generate-icons.ps1
```

**На Mac/Linux:**
```bash
bash generate-icons.sh
```

#### 🎬 FFmpeg вариант:

**На Windows:**
```bash
.\generate-icons-ffmpeg.bat
```

**На Mac/Linux:**
```bash
bash generate-icons-ffmpeg.sh
```

**На любой ОС (PowerShell):**
```bash
.\generate-icons-ffmpeg.ps1
```

**Или вручную (один размер):**
```bash
ffmpeg -i source-icon.png -vf scale=192:192 icons/icon-192.png -y
```

➡️ Все команды FFmpeg смотрите в [ffmpeg-commands.md](ffmpeg-commands.md)

### Шаг 4: Использование результатов

1. ✅ Скопируйте папку `icons/` в `public/` вашего проекта
2. ✅ Откройте `header.txt`
3. ✅ Копируйте HTML из section "Favicon & Icons" в `<head>` вашего index.html
4. ✅ Копируйте "MANIFEST.JSON ICONS ARRAY" в manifest.json
5. ✅ Запустите `npm run build`

## 📁 Структура результатов

```
icons/
├── icon-72.png              ← 72×72
├── icon-96.png              ← 96×96
├── icon-128.png             ← 128×128
├── icon-144.png             ← 144×144 (Windows)
├── icon-192.png             ← 192×192 (Android)
├── icon-192-maskable.png    ← 192×192 (PWA)
├── icon-256.png             ← 256×256
├── icon-384.png             ← 384×384
├── icon-512.png             ← 512×512 (PWA splash)
├── apple/
│   ├── Icon-Small.png       (29×29)
│   ├── Icon-Small@2x.png    (58×58)
│   ├── Icon-Small@3x.png    (87×87)
│   ├── Icon-Small-40.png    (40×40)
│   ├── Icon-Small-40@2x.png (80×80)
│   ├── Icon-Small-40@3x.png (120×120)
│   ├── Icon-60@2x.png       (120×120)
│   ├── Icon-60@3x.png       (180×180)
│   ├── Icon-76.png          (76×76)
│   ├── Icon-76@2x.png       (152×152)
│   └── Icon-83.5@2x.png     (167×167)
└── android/
    ├── mipmap-ldpi/ic_launcher.png   (36×36)
    ├── mipmap-mdpi/ic_launcher.png   (48×48)
    ├── mipmap-hdpi/ic_launcher.png   (72×72)
    ├── mipmap-xhdpi/ic_launcher.png  (96×96)
    ├── mipmap-xxhdpi/ic_launcher.png (144×144)
    └── mipmap-xxxhdpi/ic_launcher.png(192×192)

+ header.txt ← готовый HTML для копирования
```

## 📄 Полный пример использования

### 1. Структура проекта (Vite + React)

```
my-project/
├── public/
│   ├── favicon.ico
│   ├── manifest.json
│   └── icons/           ← Результаты из скрипта
│       ├── icon-*.png
│       ├── apple/
│       └── android/
├── src/
├── index.html
├── vite.config.ts
└── scripts/
    ├── generate-icons.bat
    ├── generate-icons.ps1
    └── source-icon.png  ← Исходная 512×512 иконка
```

### 2. Команда для запуска

```bash
# Перейдите в папку scripts/
cd scripts

# Положите source-icon.png в эту папку

# Запустите скрипт
.\generate-icons.ps1

# Или на Windows
.\generate-icons.bat
```

### 3. После выполнения скрипта

```bash
# Скопируйте папку icons/ из scripts в public/
cp -r scripts/icons public/

# Или вручную через Explorer
# Из scripts/icons скопируйте в public/icons

# Затем отредактируйте HTML
# Откройте scripts/header.txt и скопируйте HTML в index.html
```

### 4. Обновите manifest.json

```json
{
  "name": "My App",
  "short_name": "App",
  "description": "...",
  "start_url": "/",
  "display": "standalone",
  "icons": [
    // ВСТАВЬТЕ СЮДА СОДЕРЖИМОЕ ИЗ header.txt
  ]
}
```

## 🔧 Параметры скрипта

### PowerShell версия

```powershell
# По умолчанию
.\generate-icons.ps1

# С пользовательскими параметрами
.\generate-icons.ps1 `
  -SourceIcon "my-icon.png" `
  -OutputDir "output" `
  -HeaderFile "html-header.txt" `
  -ProjectName "My Awesome App"
```

### Batch версия

Отредактируйте переменные в начале `generate-icons.bat`:

```batch
set SOURCE_ICON=source-icon.png
set OUTPUT_DIR=icons
set HEADER_FILE=header.txt
set PROJECT_NAME=My App
```

## 🧪 Тестирование

После создания иконок протестируйте на разных платформах:

### iOS (Safari)
```
1. Откройте сайт на iPhone
2. Нажмите Share → Add to Home Screen
3. Проверьте иконку
```

### Android (Chrome)
```
1. Откройте сайт в Chrome
2. Нажмите меню → Install app
3. Проверьте иконку
```

### Desktop (Chrome)
```
1. DevTools → Application → Manifest
2. Проверьте все иконки загружены
3. Нажмите "Install app"
```

### Lighthouse PWA Audit
```
1. DevTools → Lighthouse
2. Выберите PWA
3. Запустите аудит
4. Проверьте: Icons present ✓
```

## 🔄 Сравнение: ImageMagick vs FFmpeg

Оба инструмента отлично подходят для генерации иконок. Вот как они отличаются:

| Критерий | ImageMagick | FFmpeg |
|----------|-------------|--------|
| **Установка** | Простая | Простая |
| **Размер** | ~40 MB | ~60 MB |
| **Скорость** | Средняя | Быстрая |
| **Функциональность** | Узконаправленная (изображения) | Универсальная (видео, аудио, изображения) |
| **Качество масштабирования** | Отличное | Отличное |
| **Кроссплатформность** | Да (Windows, Mac, Linux) | Да (Windows, Mac, Linux) |
| **Сложность команд** | Проще | Проще |
| **Документация** | Обширная | Очень обширная |
| **Поддержка форматов** | Все основные | Все основные |
| **Интеграция в проект** | Хорошо для конкретной задачи | Универсальный инструмент |

### Когда выбрать что?

**ImageMagick:**
- 🎯 Нужна специализированная программа только для изображений
- 🏠 Есть Windows и нужна простота установки
- ⚡ Иконки не критичны по времени

**FFmpeg:**
- 🎬 Может понадобиться для видео/аудио в будущем
- 🐧 Работаете в Linux/Mac среде
- ⚙️ Уже установлен FFmpeg в проекте

### Пример использования обоих

```bash
# ImageMagick
magick source-icon.png -resize 192x192 output.png

# FFmpeg
ffmpeg -i source-icon.png -vf scale=192:192 output.png -y
```

Результат **идентичный**! Выбирайте то, что удобнее.

➡️ **Все команды FFmpeg:** смотрите [ffmpeg-commands.md](ffmpeg-commands.md)

## ❓ Частые вопросы

### Почему генератор требует ImageMagick?

ImageMagick — мощный инструмент для обработки изображений. Он:
- Быстро масштабирует изображения
- Сохраняет качество
- Поддерживает все форматы
- Работает на всех ОС

### Где взять исходную иконку?

Варианты:
1. **Figma** — создайте и экспортируйте 512×512
2. **Illustrator/Photoshop** — сохраните как PNG
3. **Canva** — профессиональные иконки с скачиванием
4. **Looka** — AI генератор логотипов
5. **Online редакторы** — canva.com, figma.com

### Что такое @2x и @3x?

- `@1x` — базовое разрешение (не указывается в имени)
- `@2x` — двойное разрешение (Retina, iPhone 6-8)
- `@3x` — тройное разрешение (Plus, XS Max)

iOS автоматически выбирает нужный размер по экрану.

### Что такое maskable иконка?

Адаптивная иконка для Android 10+. Может быть обрезана в разные формы (круг, квадрат с углами и т.д.). 

Рекомендуется разместить логотип в центре с паддингом 72px от края для 192×192.

### Скрипт выдает ошибку "magick not found"

1. Переустановите ImageMagick
2. При установке выберите "Add to PATH"
3. Перезагрузитесь
4. Проверьте: откройте PowerShell и введите `magick --version`

## 📚 Дополнительные материалы

### Документация

- [MDN: Web Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)
- [MDN: Apple Touch Icon](https://developer.mozilla.org/en-US/docs/Learn_web_development/CSS_layout/Responsive_Design#icons)
- [Google: Web App Icons](https://web.dev/add-manifest/#icons)
- [Android: App Icons Guide](https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher)

### Генераторы

- https://www.favicon-generator.org/
- https://icon-set.vercel.app/
- https://pwa-asset-generator.firebaseapp.com/

### Инструменты оптимизации

```bash
# Сжатие PNG
npm install -g imagemin-cli imagemin-pngquant
imagemin icons/*.png --out-dir=icons --plugin=pngquant
```

## 🐛 Решение проблем

### "Source icon not found"
→ Убедитесь что файл `source-icon.png` в папке скрипта

### "ImageMagick not found"
→ Переустановите ImageMagick, выберите "Add to PATH"

### Иконки получились размытыми
→ Убедитесь что исходная иконка минимум 512×512px
→ Или попробуйте еще одну иконку

### Header.txt не создался
→ Проверьте права доступа к папке
→ Попробуйте запустить PowerShell от администратора

### Иконки не работают в PWA
→ Проверьте что manifest.json подключен в HTML
→ Откройте DevTools → Application → Manifest
→ Проверьте что все paths корректные (/icons/...)

## 📝 История версий

### v1.0 (2026-04-29)
- ✅ Поддержка 26 иконок
- ✅ Batch + PowerShell версии
- ✅ Автогенерация HTML header
- ✅ Структура папок для iOS/Android

## 📄 Лицензия

MIT — используйте свободно!

## 👨‍💻 Автор

Создано для быстрой генерации иконок PWA приложений.

---

**Совет:** Сохраните этот README для будущих проектов! Просто копируйте скрипты и используйте по мере необходимости.

