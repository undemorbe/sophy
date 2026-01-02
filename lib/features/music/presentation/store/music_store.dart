import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:sophy/features/music/domain/entities/track.dart';
import 'package:sophy/features/music/domain/usecases/get_recommendations.dart';
import 'package:sophy/features/music/domain/usecases/get_tracks.dart';
import 'package:sophy/features/music/domain/usecases/upload_track.dart';

part 'music_store.g.dart';

class MusicStore extends _MusicStore with _$MusicStore {
  MusicStore(
    super.getTracksUseCase,
    super.uploadTrackUseCase,
    super.getRecommendationsUseCase,
  );
}

abstract class _MusicStore with Store {
  final GetTracks _getTracksUseCase;
  final UploadTrack _uploadTrackUseCase;
  final GetRecommendations _getRecommendationsUseCase;

  _MusicStore(
    this._getTracksUseCase,
    this._uploadTrackUseCase,
    this._getRecommendationsUseCase,
  );

  @observable
  ObservableList<Track> tracks = ObservableList<Track>();

  @observable
  ObservableList<Track> favorites = ObservableList<Track>();

  @observable
  bool isLoading = false;

  @observable
  bool isUploading = false;

  @observable
  String? errorMessage;

  @observable
  String searchQuery = '';

  @observable
  String? selectedCategory;

  @computed
  List<Track> get filteredTracks {
    return tracks.where((track) {
      final matchesQuery =
          searchQuery.isEmpty ||
          track.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          track.artist.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (track.category?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false);

      final matchesCategory =
          selectedCategory == null || track.category == selectedCategory;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  @computed
  List<Track> get recommendations {
    return _getRecommendationsUseCase(
      allTracks: tracks,
      favorites: favorites,
    );
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void setCategory(String? category) {
    selectedCategory = category;
  }

  @action
  void toggleFavorite(Track track) {
    if (favorites.any((t) => t.id == track.id)) {
      favorites.removeWhere((t) => t.id == track.id);
    } else {
      favorites.add(track);
    }
  }

  bool isFavorite(Track track) {
    return favorites.any((t) => t.id == track.id);
  }

  @action
  Future<void> fetchTracks() async {
    isLoading = true;
    errorMessage = null;
    try {
      final fetchedTracks = await _getTracksUseCase();
      tracks.clear();
      tracks.addAll(fetchedTracks);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> uploadTrack({
    required String name,
    required String artist,
    required File imageFile,
    required File songFile,
    required String? category,
  }) async {
    isUploading = true;
    errorMessage = null;
    try {
      final newTrack = await _uploadTrackUseCase(
        name: name,
        artist: artist,
        imageFile: imageFile,
        songFile: songFile,
        category: category,
      );
      tracks.insert(0, newTrack);
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isUploading = false;
    }
  }
}
