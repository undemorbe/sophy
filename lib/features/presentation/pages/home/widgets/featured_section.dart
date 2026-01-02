import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/features/presentation/widgets/cute_widgets.dart';
import 'package:sophy/features/presentation/widgets/cached_image.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final musicStore = getIt<MusicStore>();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Text(
              "Featured for You ✨",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 180,
            child: Observer(
              builder: (context) {
                final tracks = musicStore.tracks;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final track = (tracks.isNotEmpty && index < tracks.length)
                        ? tracks[index]
                        : null;
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 16),
                      child: CuteCard(
                        padding: EdgeInsets.zero,
                        color: index % 2 == 0
                            ? theme.colorScheme.secondary.withValues(alpha: 0.5)
                            : theme.colorScheme.tertiary.withValues(alpha: 0.5),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (track != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  24,
                                ), // Match CuteCard radius
                                child: Opacity(
                                  opacity: 0.6,
                                  child: MyCachedImage(
                                    imageUrl: track.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Daily Mix",
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 2,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                  ),
                                  Text(
                                    "#${index + 1}",
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            if (track == null)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Icon(
                                  Icons.music_note_rounded,
                                  size: 40,
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
