import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/widgets/track_card.dart';

class RecentlyPlayedSection extends StatelessWidget {
  const RecentlyPlayedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: Text(
                "Recently Played 🎧",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          final trackIndex = index - 1;
          return TrackCard(
            trackName: 'Track $trackIndex',
            artistName: 'Artist $trackIndex',
            musicImageUrl:
                'https://www.rollingstone.com/wp-content/uploads/2024/10/sh2.jpg?w=1581&h=1054&crop=1',
            datePublishedFormated: '2025-02-12',
          );
        },
        childCount: 11, // 10 items + header
      ),
    );
  }
}
