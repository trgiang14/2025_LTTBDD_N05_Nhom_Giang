import 'package:flutter/material.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({super.key});

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  bool isPlaying = false;
  bool isShuffle = false;
  bool isRepeat = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //shuffle + repeat
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() => isShuffle = !isShuffle);
              },
              icon: Icon(
                Icons.shuffle,
                color: isShuffle ? Colors.deepPurple : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        //play/pause + previous + next
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.skip_previous_rounded),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            IconButton(
              iconSize: 56,
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                setState(() => isPlaying = !isPlaying);
              },
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_next_rounded),
              iconSize: 36,
            ),
          ],
        ),
      ],
    );
  }
}
