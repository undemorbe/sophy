// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String user_greeting(String username) {
    return 'Hey $username';
  }

  @override
  String homepage_appbar(String is_mobile) {
    String _temp0 = intl.Intl.selectLogic(is_mobile, {
      '1': 'New Drops',
      '2': 'New Drops | Let\'\'s listen them!',
      'other': 'New Drops',
    });
    return '$_temp0';
  }

  @override
  String searchpage_appbar(String is_mobile) {
    String _temp0 = intl.Intl.selectLogic(is_mobile, {
      '1': 'Search',
      '2': 'Search | Listen',
      'other': 'Search',
    });
    return '$_temp0';
  }

  @override
  String liblarypage_appbar(String is_mobile) {
    String _temp0 = intl.Intl.selectLogic(is_mobile, {
      '1': 'Discovery',
      '2': 'Discovery | Listen',
      'other': 'Discovery',
    });
    return '$_temp0';
  }

  @override
  String searchwidget_hint_text(String hint_text_type) {
    String _temp0 = intl.Intl.selectLogic(hint_text_type, {
      '1': 'Songs, authors, playlists',
      '2': 'Username',
      'other': 'Search',
    });
    return '$_temp0';
  }

  @override
  String get library_music_categories => 'Categories';

  @override
  String get library_music_trending => 'Trending right now';

  @override
  String get library_music_favorites => 'Your favorites';

  @override
  String get bottom_navigation_bar_homepage => 'Home';

  @override
  String get bottom_navigation_bar_search => 'Search';

  @override
  String get bottom_navigation_bar_now_playing => 'Playing';

  @override
  String get bottom_navigation_bar_playlists => 'Library';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_theme_mode => 'Theme Mode';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_color_scheme => 'Color Scheme';

  @override
  String get settings_crash_reporting => 'Crash Reporting';

  @override
  String get settings_crash_reporting_subtitle =>
      'Automatically send error reports to developers';

  @override
  String get settings_privacy => 'Privacy';
}
