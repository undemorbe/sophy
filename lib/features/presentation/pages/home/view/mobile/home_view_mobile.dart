import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/pages/home/widgets/featured_section.dart';
import 'package:sophy/features/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:sophy/features/presentation/pages/home/widgets/recommended_section.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';

class HomeViewMobile extends StatefulWidget {
  const HomeViewMobile({super.key});

  @override
  State<HomeViewMobile> createState() => _HomeViewMobileState();
}

class _HomeViewMobileState extends State<HomeViewMobile> {
  final _musicStore = getIt<MusicStore>();
  final _playerStore = getIt<PlayerStore>();

  @override
  void initState() {
    super.initState();
    _musicStore.fetchTracks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Observer(
        builder: (_) {
          if (_musicStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_musicStore.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${_musicStore.errorMessage}',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _musicStore.fetchTracks,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              const HomeAppBar(isMobile: true),
              const FeaturedSection(),
              const RecommendedSection(),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "All Tracks",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (_musicStore.tracks.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No tracks found',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
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
                  }, childCount: _musicStore.tracks.length),
                ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          );
        },
      ),
    );
  }
}
