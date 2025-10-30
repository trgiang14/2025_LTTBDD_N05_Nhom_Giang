import 'package:flow_up/widgets/player_controls.dart';
import 'package:flutter/material.dart';
import '/widgets/song_progress_bar.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        elevation: 0,
        title: const Text(
          'Flow Music',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                  image: const DecorationImage(
                    image: AssetImage(
                      'images/pexels-julias-torten-und-tortchen-434418-31001122.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              //Tên bài hát+ca sĩ
              const Text(
                'Night Changes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'One Dỉrection',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
              const SizedBox(height: 24),
              //Thanh tiến trình
              const SongProgressBar(current: 60, total: 180),
              const SizedBox(height: 20),

              //Nút điều khiển
              const PlayerControls(),
            ],
          ),
        ),
      ),
    );
  }
}
