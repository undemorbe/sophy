import 'package:sophy/features/music/domain/entities/track.dart';
import 'package:sophy/features/music/domain/repositories/music_repository.dart';

class GetTracks {
  final MusicRepository repository;

  GetTracks(this.repository);

  Future<List<Track>> call() async {
    return await repository.getTracks();
  }
}
