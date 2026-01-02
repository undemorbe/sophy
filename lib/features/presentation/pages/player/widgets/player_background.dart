import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlayerBackground extends StatelessWidget {
  final String imageUrl;
  const PlayerBackground({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
