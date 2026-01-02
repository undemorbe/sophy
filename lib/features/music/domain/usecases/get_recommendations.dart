import 'package:sophy/features/music/domain/entities/track.dart';

class GetRecommendations {
  List<Track> call({
    required List<Track> allTracks,
    required List<Track> favorites,
    int limit = 5,
  }) {
    if (allTracks.isEmpty) return [];

    if (favorites.isEmpty) {
      final list = List<Track>.from(allTracks)..shuffle();
      return list.take(limit).toList();
    }

    final favCategories = favorites
        .map((t) => t.category)
        .where((c) => c != null)
        .toSet();

    if (favCategories.isEmpty) {
      final list = List<Track>.from(allTracks)..shuffle();
      return list.take(limit).toList();
    }

    final recommended = allTracks
        .where((t) => !_isFavorite(t, favorites) && favCategories.contains(t.category))
        .toList();

    if (recommended.isEmpty) {
      final list = List<Track>.from(allTracks)..shuffle();
      return list.take(limit).toList();
    }

    recommended.shuffle();
    return recommended.take(limit).toList();
  }

  bool _isFavorite(Track track, List<Track> favorites) {
    return favorites.any((t) => t.id == track.id);
  }
}
