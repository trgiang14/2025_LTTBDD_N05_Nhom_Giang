import 'package:flutter/material.dart';

class SongProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final Function(int)? onSeek;

  const SongProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? current / total : 0.0;

    String formatTime(int seconds) {
      final minutes = (seconds ~/ 60).toString().padLeft(1, '0');
      final secs = (seconds % 60).toString().padLeft(2, '0');
      return '$minutes:$secs';
    }

    return Column(
      children: [
        Slider(
          value: progress.clamp(0.0, 1.0),
          onChanged: onSeek != null
              ? (value) {
                  final newPosition = (value * total).round();
                  onSeek!(newPosition);
                }
              : null,
          activeColor: Colors.deepPurple,
          inactiveColor: Colors.deepPurple.shade100,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(formatTime(current)), Text(formatTime(total))],
          ),
        ),
      ],
    );
  }
}
