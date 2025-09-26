# News App

Flutter-приложение для просмотра новостей с поддержкой аутентификации, поиска и персонализации.

## Описание

News App - это современное мобильное приложение для чтения новостей, построенное на Flutter. Приложение предоставляет пользователям возможность просматривать последние новости, искать статьи по ключевым словам, сохранять историю поиска и настраивать персональный профиль.

## Основные функции

- 📰 **Лента новостей** - просмотр актуальных новостей с пагинацией
- 🔍 **Поиск новостей** - поиск статей по ключевым словам
- 📱 **Адаптивный дизайн** - поддержка светлой и темной тем
- 🌍 **Мультиязычность** - поддержка русского, английского и казахского языков
- 👤 **Профиль пользователя** - управление личными данными и аватаром
- 📊 **История поиска** - сохранение и управление поисковыми запросами
- 🔐 **Аутентификация** - вход/регистрация через Firebase Auth


## Архитектура

Приложение построено с использованием Clean Architecture и следующих паттернов:

- **BLoC** для управления состоянием
- **Repository Pattern** для работы с данными
- **Dependency Injection** с GetIt
- **Go Router** для навигации

### Структура проекта

```
lib/
├── core/                     # Основные компоненты
│   ├── bloc/                 # Глобальные BLoC/Cubit
│   ├── constants/            # Константы приложения
│   ├── router/               # Конфигурация маршрутизации
│   ├── theme/                # Темы приложения
│   └── ui/                   # Общие UI компоненты
├── features/                 # Функциональные модули
│   ├── auth/                 # Аутентификация
│   ├── history/              # История поиска
│   ├── main/                 # Главная страница с новостями
│   ├── profile/              # Профиль пользователя
│   ├── search/               # Поиск новостей
│   └── scaffold_with_nav_bar/# Навигационная панель
├── generated/                # Сгенерированные файлы
├── l10n/                     # Локализация
└── services/                 # Сервисы
```

## Требования

- Flutter SDK: ^3.8.1
- Dart SDK: ^3.8.1
- iOS 12.0+ / Android API 23+
- Firebase проект (для аутентификации и уведомлений)

## Настройка

### 1. Клонирование репозитория

```bash
git clone <repository-url>
cd news
```

### 2. Установка зависимостей

```bash
flutter pub get
```

### 3. Настройка Firebase

1. Создайте новый проект в [Firebase Console](https://console.firebase.google.com/)
2. Добавьте Android и iOS приложения
3. Скачайте конфигурационные файлы:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`
4. Активируйте следующие сервисы:
   - Authentication (Email/Password)
   - Firestore Database
   - Storage

### 4. Настройка API ключей

Создайте файл `.env` в корне проекта:

```env
BASE_URL=https://your_api
API_KEY=your_news_api_key_here
```

Получите API ключ на [NewsAPI.org](https://your_api/)

### 5. Генерация кода

```bash
flutter packages pub run build_runner build
```

## Запуск приложения

### Разработка

```bash
flutter run
```

### Продукция

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Тестирование

Проект включает юнит и виджет тесты:

```bash
# Запуск всех тестов
flutter test

# Запуск с покрытием
flutter test --coverage
```

## Основные зависимости

### UI и навигация
- `go_router` - декларативная маршрутизация
- `flutter_localizations` - интернационализация

### Управление состоянием
- `flutter_bloc` - BLoC паттерн
- `provider` - Provider паттерн

### Сеть и данные
- `dio` - HTTP клиент
- `shared_preferences` - локальное хранилище

### Firebase
- `firebase_core` - основа Firebase
- `firebase_auth` - аутентификация
- `cloud_firestore` - база данных
- `firebase_storage` - файловое хранилище
- `firebase_messaging` - push уведомления

### Утилиты
- `get_it` - dependency injection
- `equatable` - сравнение объектов
- `intl` - форматирование дат
- `image_picker` - выбор изображений
- `image_cropper` - обрезка изображений

### Отладка
- `talker_flutter` - логирование
- `talker_dio_logger` - логи HTTP запросов
- `talker_bloc_logger` - логи BLoC событий

## Функциональность по модулям

### Authentication (`features/auth/`)
- Вход в систему
- Регистрация
- Сброс пароля
- Управление профилем

### Main (`features/main/`)
- Лента новостей
- Топ новости
- Детальный просмотр статей
- Pull-to-refresh

### Search (`features/search/`)
- Поиск по ключевым словам
- Результаты поиска

### History (`features/history/`)
- История поисковых запросов
- Очистка истории

### Profile (`features/profile/`)
- Редактирование профиля
- Загрузка аватара
- Настройки приложения
- Выход из системы

## Конфигурация

### Темы
Приложение поддерживает светлую и темную темы, настроенные в `lib/core/theme/`.

### Локализация
Поддерживаемые языки:
- Русский (ru)
- Английский (en)  
- Казахский (kk)

Файлы локализации находятся в `lib/l10n/`.

### Маршрутизация
Конфигурация маршрутов находится в `lib/core/router/router.dart`.

## Contributing

1. Fork проект
2. Создайте feature branch (`git checkout -b feature/amazing-feature`)
3. Commit изменения (`git commit -m 'Add amazing feature'`)
4. Push в branch (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

## 👨‍💻 Автор

**Beg1sJR**
- GitHub: [@Beg1sJR](https://github.com/Beg1sJR)

⭐ **Если вам понравился проект, поставьте звездочку!**
 a full API reference.
