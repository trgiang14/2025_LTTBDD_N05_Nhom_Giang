import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ProgressBar(
        progress: Duration(seconds: current),
        total: Duration(seconds: total),
        buffered: Duration(seconds: total),
        onSeek: onSeek != null
            ? (duration) {
                onSeek!(duration.inSeconds);
              }
            : null,
        // Tùy chỉnh màu sắc
        progressBarColor: Colors.deepPurple,
        baseBarColor: Colors.deepPurple.shade100,
        bufferedBarColor: Colors.deepPurple.shade50,
        thumbColor: Colors.deepPurple,
        barHeight: 4.0,
        thumbRadius: 6.0,
        // Tùy chỉnh text
        timeLabelTextStyle: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 12,
        ),
      ),
    );
  }
}
