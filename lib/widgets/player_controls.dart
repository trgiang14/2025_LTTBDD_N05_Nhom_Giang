import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //shuffle + repeat
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shuffle, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 36,
              onPressed: onPrevious,
              icon: const Icon(Icons.skip_previous_rounded),
            ),

            const SizedBox(width: 16),

            IconButton(
              onPressed: onPlayPause,
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: onNext,
              icon: const Icon(Icons.skip_next_rounded),
              iconSize: 36,
            ),
          ],
        ),
      ],
    );
  }
}
