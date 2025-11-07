import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicService extends ChangeNotifier {
  // Singleton pattern
  static final MusicService _instance = MusicService._internal();
  factory MusicService() => _instance;
  MusicService._internal();

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Trạng thái
  Map<String, dynamic>? _currentSong;
  List<Map<String, dynamic>> _playlist = [];
  int _currentIndex = 0;

  // Getters
  bool get isPlaying => _audioPlayer.playing;
  Duration get currentPosition => _audioPlayer.position;
  Duration get totalDuration => _audioPlayer.duration ?? Duration.zero;
  Map<String, dynamic>? get currentSong => _currentSong;
  List<Map<String, dynamic>> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get hasCurrentSong => _currentSong != null;

  // Stream getters
  Stream<bool> get playingStream => _audioPlayer.playingStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  // Khởi tạo
  void initialize() {
    // Lắng nghe các stream để cập nhật UI qua Provider
    _audioPlayer.playingStream.listen((_) => notifyListeners());
    _audioPlayer.positionStream.listen((_) => notifyListeners());
    _audioPlayer.durationStream.listen((_) => notifyListeners());
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  // Phát bài hát
  Future<void> playSong(
    Map<String, dynamic> song, {
    List<Map<String, dynamic>>? playlist,
    int? index,
  }) async {
    final isDifferentSong = _currentSong?['url'] != song['url'];
    _currentSong = song;

    if (playlist != null) {
      _playlist = playlist;
      _currentIndex = index ?? 0;
    }

    if (!isDifferentSong) {
      await _audioPlayer.play();
      notifyListeners();
      return;
    }

    try {
      final url = song['url'] ?? '';

      if (url.startsWith('assets/')) {
        await _audioPlayer.setAsset(url);
      } else if (url.startsWith('asset://')) {
        await _audioPlayer.setAsset(url.replaceFirst('asset://', 'assets/'));
      } else if (url.startsWith('http://') || url.startsWith('https://')) {
        await _audioPlayer.setUrl(url);
      } else if (url.isNotEmpty) {
        await _audioPlayer.setFilePath(url);
      }

      await _audioPlayer.play();
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing song: $e');
    }
  }

  // Play/Pause
  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      debugPrint('togglePlayPause error: $e');
    }
  }

  // Tua nhạc
  Future<void> seekTo(int seconds) async {
    final total = _audioPlayer.duration ?? Duration.zero;
    if (total == Duration.zero) return;
    final target = Duration(seconds: seconds.clamp(0, total.inSeconds));
    await _audioPlayer.seek(target);
  }

  // Bài tiếp theo
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

  // Bài trước
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

  // Dọn dẹp
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
