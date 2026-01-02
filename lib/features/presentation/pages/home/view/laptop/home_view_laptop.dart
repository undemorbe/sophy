import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/home/widgets/featured_section.dart';
import 'package:sophy/features/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';

class HomeViewLaptop extends StatefulWidget {
  const HomeViewLaptop({super.key});

  @override
  State<HomeViewLaptop> createState() => _HomeViewLaptopState();
}

class _HomeViewLaptopState extends State<HomeViewLaptop> {
  final MusicStore _musicStore = getIt<MusicStore>();
  final PlayerStore _playerStore = getIt<PlayerStore>();

  @override
  void initState() {
    super.initState();
    _musicStore.fetchTracks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/author');
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Observer(builder: (context) {
        return CustomScrollView(
          slivers: [
            HomeAppBar(isMobile: isMobile),
            const FeaturedSection(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                child: Text(
                  "Recently Played 🎧",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_musicStore.isLoading)
              const SliverToBoxAdapter(
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                )),
              )
            else if (_musicStore.tracks.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child:
                      Text('No tracks found', style: theme.textTheme.bodyLarge),
                )),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final track = _musicStore.tracks[index];
                      return TrackCard(
                        trackName: track.name,
                        artistName: track.artist,
                        musicImageUrl: track.imageUrl,
                        datePublishedFormated:
                            "${track.createdAt.year}-${track.createdAt.month}-${track.createdAt.day}",
                        isFavorite: _musicStore.isFavorite(track),
                        onFavorite: () => _musicStore.toggleFavorite(track),
                        onPlay: () {
                          _playerStore.playTrack(track);
                          context.push('/player');
                        },
                      );
                    },
                    childCount: _musicStore.tracks.length,
                  ),
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        );
      }),
    );
  }
}
