import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sophy/core/di/service_locator.dart';

Future<void> initDependencies() async {
  // 1. Initialize Supabase
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  // 2. Setup Service Locator (DI)
  setupServiceLocator();

  // 3. Wait for any other async initialization here
  // e.g. Hive.initFlutter(), etc.

  // minimal delay to let animation finish if it's too fast
  await Future.delayed(const Duration(seconds: 2));
}
