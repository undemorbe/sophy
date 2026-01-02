// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Русский';

  @override
  String user_greeting(String username) {
    return 'Hey $username';
  }

  @override
  String homepage_appbar(String is_mobile) {
    String _temp0 = intl.Intl.selectLogic(is_mobile, {
      '1': 'Новинки',
      '2': 'Новинки | Давай послушаем!',
      'other': 'Новинки',
    });
    return '$_temp0';
  }

  @override
  String searchpage_appbar(String is_mobile) {
    String _temp0 = intl.Intl.selectLogic(is_mobile, {
      '1': 'Поиск',
      '2': 'Поиск | Слушать',
      'other': 'Поиск',
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
      '1': 'Песни, авторы, плейлисты',
      '2': 'Имя пользователя',
      'other': 'Поиск',
    });
    return '$_temp0';
  }

  @override
  String get library_music_categories => 'Жанры';

  @override
  String get library_music_trending => 'В тренде';

  @override
  String get library_music_favorites => 'Ваши любимые';

  @override
  String get bottom_navigation_bar_homepage => 'Главная';

  @override
  String get bottom_navigation_bar_search => 'Поиск';

  @override
  String get bottom_navigation_bar_now_playing => 'Сейчас играет';

  @override
  String get bottom_navigation_bar_playlists => 'Медиатека';
}
