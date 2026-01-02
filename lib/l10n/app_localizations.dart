import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// Current language in app
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// User greeting in app (Hello + username)
  ///
  /// In en, this message translates to:
  /// **'Hey {username}'**
  String user_greeting(String username);

  /// Home page appbar for mobile / laptop version text, 1 - mobile, 2 - laptop
  ///
  /// In en, this message translates to:
  /// **'{is_mobile, select, 1{New Drops} 2{New Drops | Let\'\'s listen them!} other{New Drops}}'**
  String homepage_appbar(String is_mobile);

  /// Search page appbar for mobile / laptop version text, 1 - mobile, 2 - laptop
  ///
  /// In en, this message translates to:
  /// **'{is_mobile, select, 1{Search} 2{Search | Listen} other{Search}}'**
  String searchpage_appbar(String is_mobile);

  /// Library page appbar for mobile / laptop version text, 1 - mobile, 2 - laptop
  ///
  /// In en, this message translates to:
  /// **'{is_mobile, select, 1{Discovery} 2{Discovery | Listen} other{Discovery}}'**
  String liblarypage_appbar(String is_mobile);

  /// Search widget hint text, 1 - songs/authors/playlists, 2 - users in app
  ///
  /// In en, this message translates to:
  /// **'{hint_text_type, select, 1{Songs, authors, playlists} 2{Username} other{Search}}'**
  String searchwidget_hint_text(String hint_text_type);

  /// Text for library_music_categories
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get library_music_categories;

  /// Text for library_music_trending layer
  ///
  /// In en, this message translates to:
  /// **'Trending right now'**
  String get library_music_trending;

  /// Text for library_music_favorites layer
  ///
  /// In en, this message translates to:
  /// **'Your favorites'**
  String get library_music_favorites;

  /// Text for bottom_navigation_bar_homepage layer
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottom_navigation_bar_homepage;

  /// Text for bottom_navigation_bar_search layer
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get bottom_navigation_bar_search;

  /// Text for bottom_navigation_bar_now_playing layer
  ///
  /// In en, this message translates to:
  /// **'Playing'**
  String get bottom_navigation_bar_now_playing;

  /// Text for bottom_navigation_bar_playlists / library layer
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get bottom_navigation_bar_playlists;

  /// Title for the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Label for theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// Label for theme mode (light/dark)
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get settings_theme_mode;

  /// Label for light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// Label for dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// Label for system theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_theme_system;

  /// Label for language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// Label for color scheme setting
  ///
  /// In en, this message translates to:
  /// **'Color Scheme'**
  String get settings_color_scheme;

  /// Label for crash reporting setting
  ///
  /// In en, this message translates to:
  /// **'Crash Reporting'**
  String get settings_crash_reporting;

  /// Subtitle for crash reporting setting
  ///
  /// In en, this message translates to:
  /// **'Automatically send error reports to developers'**
  String get settings_crash_reporting_subtitle;

  /// Label for privacy settings section
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settings_privacy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
