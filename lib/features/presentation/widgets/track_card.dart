import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/widgets/cute_widgets.dart';
import 'package:sophy/features/presentation/widgets/cached_image.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.trackName,
    required this.artistName,
    required this.musicImageUrl,
    this.datePublishedFormated,
    this.width,
    this.height,
    this.onPlay,
    this.onFavorite,
    this.isFavorite = false,
  });

  final String trackName;
  final String artistName;
  final String musicImageUrl;
  final String? datePublishedFormated;
  final double? width;
  final double? height;
  final VoidCallback? onPlay;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final themeof = Theme.of(context);
    final cardWidth = width ?? mediaQuery.size.width;
    final cardHeight = height ?? mediaQuery.size.height * 0.45;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: CuteCard(
        padding: EdgeInsets.zero,
        child: Container(
          height: cardHeight,
          width: cardWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: MyCachedImage(
                  imageUrl: musicImageUrl,
                  duration: const Duration(milliseconds: 500),
                  fit: BoxFit.cover,
                  height: cardHeight,
                  width: cardWidth,
                ),
              ),

              // Gradient Overlay for readability
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                    stops: const [0.5, 0.7, 1.0],
                  ),
                ),
              ),

              // Glass Info Section
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: GlassContainer(
                  blur: 15,
                  opacity: 0.2,
                  color: Colors.black,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              trackName,
                              style: themeof.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              artistName,
                              style: themeof.textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (datePublishedFormated != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                datePublishedFormated!,
                                style: themeof.textTheme.labelSmall?.copyWith(
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Actions
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CuteButton(
                            width: 50,
                            height: 50,
                            color: themeof.colorScheme.primary,
                            onPressed: onPlay ?? () {},
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Favorite Button (Top Right)
              if (onFavorite != null)
                Positioned(
                  top: 16,
                  right: 16,
                  child: GlassContainer(
                    blur: 5,
                    opacity: 0.1,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(50),
                    child: GestureDetector(
                      onTap: onFavorite,
                      child: Icon(
                        isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFavorite ? Colors.redAccent : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
