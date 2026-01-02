# Changelog

## [0.2.0] - 2026-01-02

### Refactoring & Architecture
- **Recommendation System**: Extracted recommendation logic from `MusicStore` into a dedicated `GetRecommendations` UseCase, strictly following Clean Architecture principles.
- **Dependency Injection**: Registered new `GetRecommendations` UseCase in `service_locator.dart`.
- **MusicStore**: Simplified `MusicStore` by removing business logic and delegating it to UseCases.

### Code Cleanup & Maintenance
- **Deprecations**: 
  - Replaced all occurrences of `withOpacity` with `withValues` (Flutter 3.22+).
  - Replaced deprecated `Color.value` with `toARGB32()` in `SettingsService`.
- **Imports**: Removed unused and duplicate imports in `HomeViewMobile` and `LibraryPageLaptop`.

### Integrity
- Verified project structure and dependencies.
- Confirmed `pubspec.yaml` integrity (no `package.json` required for this Flutter project).
