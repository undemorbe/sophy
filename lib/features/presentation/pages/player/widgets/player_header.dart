import 'package:flutter/material.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
          ),
          Text("Now Playing", style: theme.textTheme.titleMedium),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded, size: 32),
          ),
        ],
      ),
    );
  }
}
