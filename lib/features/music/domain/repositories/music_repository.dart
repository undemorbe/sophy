import 'dart:io';
import 'package:sophy/features/music/domain/entities/track.dart';

abstract class MusicRepository {
  Future<List<Track>> getTracks();
  
  Future<Track> uploadTrack({
    required String name,
    required String artist,
    required File imageFile,
    required File songFile,
    required String? category,
  });
}
