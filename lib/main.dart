import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sophy/core/services/settings_service.dart';
import 'package:sophy/l10n/app_localizations.dart';
import 'package:sophy/l10n/l10n.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  /// Load .env file
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  /// Provide your own PUBLISHABLE_KEY and ANON_KEY in .env file
  // await Supabase.initialize(
  //   url: dotenv.get('PUBLISHABLE_KEY'),
  //   anonKey: dotenv.get('ANON_KEY'),
  // );

  runApp(const SophyApp());
}

class SophyApp extends StatelessWidget {
  const SophyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SettingsService(),
      builder: (context, child) {
        return MaterialApp.router(
          supportedLocales: L10n.locales,
          locale: SettingsService().locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'S O P H Y',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: SettingsService().themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
