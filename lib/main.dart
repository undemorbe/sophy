import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  /// Load .env file
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();


  /// Provide your own PUBLISHABLE_KEY and ANON_KEY in .env file
  await Supabase.initialize(
    url: dotenv.get('PUBLISHABLE_KEY'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  runApp(const SophyApp());
}

class SophyApp extends StatelessWidget {
  const SophyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'S O P H Y',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
