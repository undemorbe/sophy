import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import 'package:sophy/features/music/domain/entities/track.dart';

part 'player_store.g.dart';

class PlayerStore = _PlayerStore with _$PlayerStore;

abstract class _PlayerStore with Store {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @observable
  Track? currentTrack;

  @observable
  bool isPlaying = false;

  @observable
  Duration position = Duration.zero;

  @observable
  Duration duration = Duration.zero;

  @observable
  bool isLoading = false;

  _PlayerStore() {
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying = state.playing;
      if (state.processingState == ProcessingState.completed) {
        // Handle completion
        isPlaying = false;
        position = Duration.zero;
      }
    });

    _audioPlayer.positionStream.listen((p) {
      position = p;
    });

    _audioPlayer.durationStream.listen((d) {
      if (d != null) {
        duration = d;
      }
    });
  }

  @action
  Future<void> playTrack(Track track) async {
    try {
      isLoading = true;
      if (currentTrack?.id != track.id) {
        currentTrack = track;
        await _audioPlayer.setUrl(track.songUrl);
      }
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing track: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @action
  Future<void> resume() async {
    await _audioPlayer.play();
  }

  @action
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
