import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_album_art.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_background.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_controls.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_progress_bar.dart';
import 'package:sophy/features/presentation/pages/player/widgets/player_track_info.dart';

class PlayerPageLaptop extends StatefulWidget {
  const PlayerPageLaptop({super.key});

  @override
  State<PlayerPageLaptop> createState() => _PlayerPageLaptopState();
}

class _PlayerPageLaptopState extends State<PlayerPageLaptop> {
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
                child: Row(
                  children: [
                    // Left side: Album Art
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                             // Make it responsive but bounded
                             final size = constraints.maxWidth * 0.6;
                             return PlayerAlbumArt(
                               imageUrl: imageUrl,
                               size: size.clamp(300.0, 600.0),
                             );
                          }
                        ),
                      ),
                    ),
                    
                    // Right side: Controls & Info
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayerTrackInfo(title: title, artist: artist),
                            
                            const SizedBox(height: 48),
                            
                            PlayerProgressBar(
                              value: (duration > 0) ? position / duration : 0.0,
                              onChanged: (v) {
                                final seekTo = Duration(
                                  seconds: (v * duration).toInt(),
                                );
                                _playerStore.seek(seekTo);
                              },
                            ),
                            
                            const SizedBox(height: 32),
                            
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
