import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophy/core/theme/colors.dart';

class SettingsService extends ChangeNotifier {
  static final SettingsService _instance = SettingsService._internal();

  factory SettingsService() {
    return _instance;
  }

  SettingsService._internal();

  late SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');
  Color _seedColor = AppColors.pastelPink;
  bool _isCrashReportingEnabled = true;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  Color get seedColor => _seedColor;
  bool get isCrashReportingEnabled => _isCrashReportingEnabled;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    // Load ThemeMode
    final themeString = _prefs.getString('theme_mode');
    if (themeString != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => ThemeMode.system,
      );
    }

    // Load Locale
    final localeCode = _prefs.getString('locale');
    if (localeCode != null) {
      _locale = Locale(localeCode);
    }

    // Load Seed Color
    final colorValue = _prefs.getInt('seed_color');
    if (colorValue != null) {
      _seedColor = Color(colorValue);
    }
    
    // Load Crash Reporting Preference
    final crashReporting = _prefs.getBool('crash_reporting_enabled');
    if (crashReporting != null) {
      _isCrashReportingEnabled = crashReporting;
    }
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    _prefs.setString('theme_mode', _themeMode.toString());
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _prefs.setString('theme_mode', _themeMode.toString());
    notifyListeners();
  }

  void setSeedColor(Color color) {
    _seedColor = color;
    _prefs.setInt('seed_color', color.toARGB32());
    notifyListeners();
  }

  void toggleLocale() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('ru');
    } else {
      _locale = const Locale('en');
    }
    _prefs.setString('locale', _locale.languageCode);
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _prefs.setString('locale', _locale.languageCode);
    notifyListeners();
  }

  void setCrashReportingEnabled(bool value) {
    _isCrashReportingEnabled = value;
    _prefs.setBool('crash_reporting_enabled', value);
    notifyListeners();
  }
}
