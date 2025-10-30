import 'package:flutter/material.dart';

class SongProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const SongProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / total;

    String formatTime(int seconds) {
      final minutes = (seconds ~/ 60).toString().padLeft(1, '0');
      final secs = (seconds % 60).toString().padLeft(2, '0');
      return '$minutes:$secs';
    }

    return Column(
      children: [
        Slider(
          value: progress,
          onChanged: (_) {},
          activeColor: Colors.deepPurple,
          inactiveColor: Colors.deepPurple.shade100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(formatTime(current)), Text(formatTime(total))],
        ),
      ],
    );
  }
}
