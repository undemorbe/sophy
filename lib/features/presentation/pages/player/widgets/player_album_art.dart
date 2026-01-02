import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/widgets/cute_widgets.dart';

class PlayerAlbumArt extends StatelessWidget {
  final String imageUrl;
  final double? size;

  const PlayerAlbumArt({super.key, required this.imageUrl, this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final artSize = size ?? MediaQuery.of(context).size.width * 0.8;
    
    return Hero(
      tag: 'album_art',
      child: CuteCard(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        child: Container(
          width: artSize,
          height: artSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
