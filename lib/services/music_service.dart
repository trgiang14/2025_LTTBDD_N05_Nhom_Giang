import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class MusicService extends ChangeNotifier {
  //Singleton pattern
  static final MusicService _instance = MusicService._insternal();
  factory MusicService() => _instance;
  MusicService._insternal();

  //Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //Trạng thái
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  Map<String, dynamic>? _currentSong;
  List<Map<String, dynamic>> _playlist = [];
  int _currentIndex = 0;

  //Getters
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  Map<String, dynamic>? get currentSong => _currentSong;
  List<Map<String, dynamic>> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get hasCurrentSong => _currentIndex != null;

  //Khởi tạo
  void initialize() {
    //Lắng nghe trạng thái phát
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    //Lắng nghe vị trí hiện tại
    _audioPlayer.onPositionChanged.listen((Duration position) {
      _currentPosition = position;
      notifyListeners();
    });

    //Lắng nghe tổng thời gian
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    //Tự động chuyển bài khi hết
    _audioPlayer.onPlayerComplete.listen((event) {
      playNext();
    });
  }

  //Phát bài hát
  Future<void> playSong(
    Map<String, dynamic> song, {
    List<Map<String, dynamic>>? playlist,
    int? index,
  }) async {
    _currentSong = song;

    if (playlist != null) {
      _playlist = playlist;
      _currentIndex = index ?? 0;
    }

    try {
      final url = song['url'] ?? '';
      await _audioPlayer.stop();

      if (url.startsWith('asset://')) {
        await _audioPlayer.play(AssetSource(url.replaceFirst('asset://', '')));
      } else if (url.startsWith('http')) {
        await _audioPlayer.play(UrlSource(url));
      } else if (url.isNotEmpty) {
        await _audioPlayer.play(DeviceFileSource(url));
      }

      notifyListeners();
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  //Play/Pause
  void togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  //Tua nhac
  Future<void> seekTo(int seconds) async {
    await _audioPlayer.setVolume(0);
    await _audioPlayer.seek(Duration(seconds: seconds));
    await Future.delayed(const Duration(milliseconds: 300));
    await _audioPlayer.setVolume(1.0);
  }

  //Bài tiếp theo
  void playNext() {
    if (_playlist.isEmpty) return;
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      playSong(
        _playlist[_currentIndex],
        playlist: _playlist,
        index: _currentIndex,
      );
    }
  }

  //Bài trước
  void playPrevious() {
    if (_playlist.isEmpty) return;
    if (_currentIndex > 0) {
      _currentIndex--;
      playSong(
        _playlist[_currentIndex],
        playlist: _playlist,
        index: _currentIndex,
      );
    }
  }

  //Dọn dẹp
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
