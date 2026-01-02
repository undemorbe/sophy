import 'package:get_it/get_it.dart';
import 'package:sophy/core/services/supabase_service.dart';
import 'package:sophy/core/store/auth_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/music/data/repositories/music_repository_impl.dart';
import 'package:sophy/features/music/domain/repositories/music_repository.dart';
import 'package:sophy/features/music/domain/usecases/get_recommendations.dart';
import 'package:sophy/features/music/domain/usecases/get_tracks.dart';
import 'package:sophy/features/music/domain/usecases/upload_track.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());
  
  // Music Feature
  getIt.registerLazySingleton<MusicRepository>(() => MusicRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GetTracks>(() => GetTracks(getIt()));
  getIt.registerLazySingleton<UploadTrack>(() => UploadTrack(getIt()));
  getIt.registerLazySingleton<GetRecommendations>(() => GetRecommendations());
  
  getIt.registerSingleton<MusicStore>(MusicStore(getIt(), getIt(), getIt()));

  // Auth & Player
  getIt.registerSingleton<AuthStore>(AuthStore(supabaseService: getIt()));
  getIt.registerSingleton<PlayerStore>(PlayerStore());
}
