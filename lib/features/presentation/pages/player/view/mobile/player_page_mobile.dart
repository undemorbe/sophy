import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_album_art.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_background.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_controls.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_header.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_progress_bar.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_track_info.dart';

class PlayerPageMobile extends StatefulWidget {
  const PlayerPageMobile({super.key});

  @override
  State<PlayerPageMobile> createState() => _PlayerPageMobileState();
}

class _PlayerPageMobileState extends State<PlayerPageMobile> {
  final PlayerStore _playerStore = getIt<PlayerStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final track = _playerStore.currentTrack;
        final imageUrl =
            track?.imageUrl ??
            'https://upload.wikimedia.org/wikipedia/commons/e/ee/Xxxtentacion_%28cropped%29.jpg';
        final title = track?.name ?? 'No Track';
        final artist = track?.artist ?? 'Unknown Artist';
        final isPlaying = _playerStore.isPlaying;
        final duration = _playerStore.duration.inSeconds.toDouble();
        final position = _playerStore.position.inSeconds.toDouble();

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              PlayerBackground(imageUrl: imageUrl),

              SafeArea(
                child: Column(
                  children: [
                    const PlayerHeader(),

                    const Spacer(),

                    PlayerAlbumArt(imageUrl: imageUrl),

                    const SizedBox(height: 48),

                    PlayerTrackInfo(title: title, artist: artist),

                    const SizedBox(height: 32),

                    PlayerProgressBar(
                      value: (duration > 0) ? position / duration : 0.0,
                      onChanged: (v) {
                        final seekTo = Duration(
                          seconds: (v * duration).toInt(),
                        );
                        _playerStore.seek(seekTo);
                      },
                    ),

                    const Spacer(),

                    PlayerControls(
                      isPlaying: isPlaying,
                      onPlayPause: () {
                        if (isPlaying) {
                          _playerStore.pause();
                        } else {
                          _playerStore.resume();
                        }
                      },
                      onNext: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Next track not implemented'),
                          ),
                        );
                      },
                      onPrevious: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Previous track not implemented'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
