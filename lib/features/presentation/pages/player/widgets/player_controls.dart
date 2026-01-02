import 'package:flutter/material.dart';
import 'package:sophy/features/presentation/widgets/cute_widgets.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shuffle_rounded, size: 28),
            color: Colors.grey,
          ),
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.skip_previous_rounded, size: 36),
          ),
          CuteButton(
            width: 80,
            height: 80,
            onPressed: onPlayPause,
            child: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.skip_next_rounded, size: 36),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.repeat_rounded, size: 28),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
