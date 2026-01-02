import 'dart:io';
import 'package:sophy/features/music/domain/entities/track.dart';
import 'package:sophy/features/music/domain/repositories/music_repository.dart';

class UploadTrack {
  final MusicRepository repository;

  UploadTrack(this.repository);

  Future<Track> call({
    required String name,
    required String artist,
    required File imageFile,
    required File songFile,
    required String? category,
  }) async {
    return await repository.uploadTrack(
      name: name,
      artist: artist,
      imageFile: imageFile,
      songFile: songFile,
      category: category,
    );
  }
}
