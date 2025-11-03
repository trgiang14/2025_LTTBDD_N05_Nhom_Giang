import 'package:flow_up/widgets/player_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/song_progress_bar.dart';
import '/services/music_service.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final musicService = Provider.of<MusicService>(context);
    final currentSong = musicService.currentSong;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        elevation: 0,
        title: const Text(
          'Flow Up Music Player',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Ảnh bài hát
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(
                      currentSong?['image'] ??
                          'images/pexels-julias-torten-und-tortchen-434418-31001122.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              //Tên bài hát+ca sĩ
              Text(
                currentSong?['title'] ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                currentSong?['artist'] ?? 'Unknown',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
              const SizedBox(height: 24),
              //Thanh tiến trình
              SongProgressBar(
                current: musicService.currentPosition.inSeconds,
                total: musicService.totalDuration.inSeconds,
                onSeek: (seconds) => musicService.seekTo(seconds),
              ),
              const SizedBox(height: 20),

              //Nút điều khiển
              PlayerControls(
                isPlaying: musicService.isPlaying,
                onPlayPause: () => musicService.togglePlayPause(),
                onNext:
                    musicService.currentIndex < musicService.playlist.length - 1
                    ? () => musicService.playNext()
                    : null,
                onPrevious: musicService.currentIndex > 0
                    ? () => musicService.playPrevious()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
