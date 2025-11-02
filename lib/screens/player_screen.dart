import 'package:flow_up/widgets/player_controls.dart';
import 'package:flutter/material.dart';
import '/widgets/song_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? song;

  const PlayerScreen({super.key, this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  //Khởi tạo player khi màn hình được tạo
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializePlayer();
  }

  //Hàm khởi tạo player và lắng nghe sự kiện
  void _initializePlayer() {
    //lắng nghe trạng thái phát
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    //lắng nghe vị trí hiện tại
    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    //lắng nghe tổng thời gian
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration;
        });
      }
    });

    //Phát nhạc nếu có URL
    if (widget.song != null && widget.song!.isNotEmpty) {
      final url = widget.song![0]['url'] ?? '';
      if (url.isNotEmpty) {
        _playSong(url);
      }
    }
  }

  //Hàm phát nhạc
  Future<void> _playSong(String url) async {
    try {
      if (url.startsWith('assets//')) {
        await _audioPlayer.play(AssetSource(url.replaceFirst('asset://', '')));
      } else if (url.startsWith('http')) {
        await _audioPlayer.play(UrlSource(url));
      } else {
        await _audioPlayer.play(DeviceFileSource(url));
      }
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  //Hàm điều khiển play/pause
  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  //Hàm tua nhạc
  void _seekTo(int seconds) {
    _audioPlayer.seek(Duration(seconds: seconds));
  }

  //Giải phóng player khi màn hình đóng
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
              SongProgressBar(
                current: _currentPosition.inSeconds,
                total: _totalDuration.inSeconds,
                onSeek: _seekTo,
              ),
              const SizedBox(height: 20),

              //Nút điều khiển
              PlayerControls(
                isPlaying: _isPlaying,
                onPlayPause: _togglePlayPause,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
