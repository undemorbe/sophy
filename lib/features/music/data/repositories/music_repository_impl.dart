import 'dart:io';
import 'package:sophy/core/services/supabase_service.dart';
import 'package:sophy/features/music/data/models/track_model.dart';
import 'package:sophy/features/music/domain/entities/track.dart';
import 'package:sophy/features/music/domain/repositories/music_repository.dart';
import 'package:uuid/uuid.dart';

class MusicRepositoryImpl implements MusicRepository {
  final SupabaseService _supabaseService;

  MusicRepositoryImpl(this._supabaseService);

  @override
  Future<List<Track>> getTracks() async {
    final tracks = await _supabaseService.getTracks();
    return tracks.cast<Track>();
  }

  @override
  Future<Track> uploadTrack({
    required String name,
    required String artist,
    required File imageFile,
    required File songFile,
    required String? category,
  }) async {
    final uuid = const Uuid().v4();
    final imagePath = '$uuid.jpg';
    final songPath = '$uuid.mp3';

    final imageUrl = await _supabaseService.uploadFile(
      imageFile,
      'covers',
      imagePath,
    );
    final songUrl = await _supabaseService.uploadFile(
      songFile,
      'songs',
      songPath,
    );

    final currentUser = _supabaseService.currentUser;
    final newTrack = TrackModel(
      id: uuid,
      name: name,
      artist: artist,
      imageUrl: imageUrl,
      songUrl: songUrl,
      userId: currentUser?.id,
      category: category,
      createdAt: DateTime.now(),
    );

    await _supabaseService.saveTrack(newTrack);
    return newTrack;
  }
}
