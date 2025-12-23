# Sophy Messenger

Sophy is a modern, secure, and intuitive messaging application built with Flutter.

## 🚀 Features (Planned)
- Real-time messaging
- Clean and modern UI
- Media sharing
- Group chats
- Push notifications

## 🏗 Architecture
This project follows **Clean Architecture** principles to ensure scalability, testability, and maintainability.

### Folder Structure
```
lib/
├── core/               # Shared logic, utilities, theme, and widgets
│   ├── error/          # Error handling (failures, exceptions)
│   ├── theme/          # App theme, colors, and fonts
│   ├── usecases/       # Base use case classes
│   ├── utils/          # Utility functions and constants
│   └── widgets/        # Common reusable widgets
├── features/           # Feature-based modules
│   └── [feature_name]/
│       ├── data/       # Data layer (repositories, data sources, models)
│       ├── domain/     # Domain layer (entities, repositories, usecases)
│       └── presentation/# Presentation layer (bloc/cubit, pages, widgets)
└── main.dart           # Entry point
```

## 🛠 Tech Stack
- **Flutter**
- **Dart**
- **Clean Architecture**
- **Bloc/Cubit** (Planned for state management)

## 🎨 Theme
The app supports both Light and Dark modes, adapting to the system preferences.

## 🏁 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/sophy.git
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 📄 License
This project is licensed under a proprietary license.
**Commercial use is strictly prohibited.**
See the [LICENSE](LICENSE) file for details.
