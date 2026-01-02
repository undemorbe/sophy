import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sophy/features/music/domain/entities/track.dart';
import 'package:sophy/features/music/domain/usecases/get_recommendations.dart';
import 'package:sophy/features/music/domain/usecases/get_tracks.dart';
import 'package:sophy/features/music/domain/usecases/upload_track.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';

@GenerateMocks([GetTracks, UploadTrack, GetRecommendations])
import 'music_store_test.mocks.dart';

void main() {
  late MusicStore musicStore;
  late MockGetTracks mockGetTracks;
  late MockUploadTrack mockUploadTrack;
  late MockGetRecommendations mockGetRecommendations;

  setUp(() {
    mockGetTracks = MockGetTracks();
    mockUploadTrack = MockUploadTrack();
    mockGetRecommendations = MockGetRecommendations();
    
    // Default stub for recommendations to avoid NPE during computed property access if accessed early
    when(mockGetRecommendations.call(
      allTracks: anyNamed('allTracks'),
      favorites: anyNamed('favorites'),
    )).thenReturn([]);

    musicStore = MusicStore(mockGetTracks, mockUploadTrack, mockGetRecommendations);
  });

  group('MusicStore', () {
    test('fetchTracks success', () async {
      final tracks = [
        Track(
          id: '1',
          name: 'Track 1',
          artist: 'Artist 1',
          imageUrl: 'url',
          songUrl: 'url',
          createdAt: DateTime.now(),
          category: 'Pop',
        ),
      ];
      when(mockGetTracks.call()).thenAnswer((_) async => tracks);

      await musicStore.fetchTracks();

      expect(musicStore.tracks.length, 1);
      expect(musicStore.tracks.first.name, 'Track 1');
      expect(musicStore.isLoading, false);
      expect(musicStore.errorMessage, null);
    });

    test('fetchTracks failure', () async {
      when(mockGetTracks.call()).thenThrow(Exception('Error'));

      await musicStore.fetchTracks();

      expect(musicStore.tracks.isEmpty, true);
      expect(musicStore.isLoading, false);
      expect(musicStore.errorMessage, contains('Error'));
    });

    test('search filters tracks', () async {
      final tracks = [
        Track(
          id: '1',
          name: 'Pop Song',
          artist: 'Artist 1',
          imageUrl: 'url',
          songUrl: 'url',
          createdAt: DateTime.now(),
          category: 'Pop',
        ),
        Track(
          id: '2',
          name: 'Rock Song',
          artist: 'Artist 2',
          imageUrl: 'url',
          songUrl: 'url',
          createdAt: DateTime.now(),
          category: 'Rock',
        ),
      ];
      when(mockGetTracks.call()).thenAnswer((_) async => tracks);
      await musicStore.fetchTracks();

      musicStore.setSearchQuery('Pop');

      expect(musicStore.filteredTracks.length, 1);
      expect(musicStore.filteredTracks.first.name, 'Pop Song');
    });
  });
}
