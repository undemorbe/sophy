import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/store/player_store.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final musicStore = getIt<MusicStore>();
    final playerStore = getIt<PlayerStore>();

    return Observer(
      builder: (context) {
        final recommendations = musicStore.recommendations;

        if (recommendations.isEmpty)
          return const SliverToBoxAdapter(child: SizedBox.shrink());

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                child: Text(
                  "Recommended for You ✨",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            final trackIndex = index - 1;
            final track = recommendations[trackIndex];
            return TrackCard(
              trackName: track.name,
              artistName: track.artist,
              musicImageUrl: track.imageUrl,
              datePublishedFormated:
                  "${track.createdAt.year}-${track.createdAt.month}-${track.createdAt.day}",
              isFavorite: musicStore.isFavorite(track),
              onFavorite: () => musicStore.toggleFavorite(track),
              onPlay: () {
                playerStore.playTrack(track);
                context.push('/player');
              },
            );
          }, childCount: recommendations.length + 1),
        );
      },
    );
  }
}
