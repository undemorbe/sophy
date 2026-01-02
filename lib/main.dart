import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/core/services/crash_reporting_service.dart';
import 'package:sophy/core/services/settings_service.dart';
import 'package:sophy/l10n/app_localizations.dart';
import 'package:sophy/l10n/l10n.dart';
import 'package:sophy/core/router/app_router.dart';
import 'package:sophy/core/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    /// Load .env file
    await dotenv.load(fileName: '.env');

    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );

    setupServiceLocator();

    await SettingsService().init();
    await CrashReportingService().init();

    // Pass all uncaught "fatal" errors from the framework to CrashReportingService
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      CrashReportingService().reportError(details.exception, details.stack);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to CrashReportingService
    PlatformDispatcher.instance.onError = (error, stack) {
      CrashReportingService().reportError(error, stack);
      return true;
    };

    runApp(const SophyApp());
  }, (error, stack) {
    CrashReportingService().reportError(error, stack);
  });
}

class SophyApp extends StatelessWidget {
  const SophyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SettingsService(),
      builder: (context, child) {
        final settings = SettingsService();
        return MaterialApp.router(
          supportedLocales: L10n.locales,
          locale: settings.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'S O P H Y',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(
            brightness: Brightness.light,
            seedColor: settings.seedColor,
          ),
          darkTheme: AppTheme.getTheme(
            brightness: Brightness.dark,
            seedColor: settings.seedColor,
          ),
          themeMode: settings.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
