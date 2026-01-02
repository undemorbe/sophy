# Sophy Music

Sophy is a modern, cross-platform music streaming application built with Flutter. It delivers a seamless listening experience with a beautiful UI that adapts to both mobile and desktop environments.

## 🚀 Features

- **Music Playback**: Robust audio player powered by `just_audio`.
- **Music Library**: Browse and manage your music collection.
- **Search**: Find tracks, artists, and albums.
- **User Authentication**: Secure login and signup via Supabase.
- **Responsive Design**: Optimized layouts for both Mobile and Laptop/Desktop.
- **Theming**: Light and Dark mode support with customizable seed colors.
- **Localization**: Multi-language support (English, Russian).

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **Backend**: [Supabase](https://supabase.com/) (Auth, Database)
- **State Management**: [MobX](https://mobx.pub/)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Audio**: [just_audio](https://pub.dev/packages/just_audio)
- **Local Storage**: [Hive](https://docs.hivedb.dev/)
- **Networking**: [Dio](https://pub.dev/packages/dio)

## 🏗 Architecture

This project follows a feature-first architecture to ensure scalability and maintainability.

```
lib/
├── core/               # Shared logic, utilities, theme, and DI
│   ├── constants/      # App constants
│   ├── di/             # Dependency Injection setup
│   ├── services/       # Core services (Supabase, Settings)
│   ├── store/          # Global MobX stores (Music, Player)
│   ├── theme/          # App theme configuration
│   └── ui/             # Shared UI components
├── features/           # Feature-based modules
│   └── presentation/   # UI layer organized by pages
│       ├── pages/      # Application screens (Home, Library, Player, etc.)
│       └── widgets/    # Feature-specific widgets
├── l10n/               # Localization files
└── main.dart           # Entry point
```

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (3.10.3 or higher)
- Supabase Project

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/sophy.git
   cd sophy
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Environment Setup:**
   Create a `.env` file in the root directory and add your Supabase credentials:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## 📄 License

This project is licensed under a proprietary license.
**Commercial use is strictly prohibited.**
See the [LICENSE](LICENSE) file for details.
