import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicService extends ChangeNotifier {
  // Singleton
  static final MusicService _instance = MusicService._internal();
  factory MusicService() => _instance;
  MusicService._internal();

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

  Stream<bool> get playingStream => _audioPlayer.playingStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  void initialize() {
    _audioPlayer.playingStream.listen((_) => notifyListeners());
    _audioPlayer.positionStream.listen((_) => notifyListeners());
    _audioPlayer.durationStream.listen((_) => notifyListeners());

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  Future<void> playSong(
    Map<String, dynamic> song, {
    List<Map<String, dynamic>>? playlist,
    int? index,
  }) async {
    try {
      // Lưu playlist và index
      if (playlist != null) {
        _playlist = playlist;
        _currentIndex = index ?? 0;
      }

      _currentSong = song;

      final url = song['url'] ?? '';
      final currentUrl = _audioPlayer.audioSource?.toString() ?? '';

      if (!currentUrl.contains(url)) {
        print('🎵 Loading: $url');

        if (url.startsWith('assets/')) {
          await _audioPlayer.setAsset(url);
        } else if (url.startsWith('asset://')) {
          await _audioPlayer.setAsset(url.replaceFirst('asset://', 'assets/'));
        } else if (url.startsWith('http://') || url.startsWith('https://')) {
          await _audioPlayer.setUrl(url);
        } else if (url.isNotEmpty) {
          await _audioPlayer.setFilePath(url);
        }

        print('Loaded, now playing...');
      }

      // Phát ngay
      await _audioPlayer.play();

      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      print('togglePlayPause error: $e');
    }
  }

  // Tua nhạc
  Future<void> seekTo(int seconds) async {
    try {
      final total = _audioPlayer.duration ?? Duration.zero;
      if (total == Duration.zero) return;

      final target = Duration(seconds: seconds.clamp(0, total.inSeconds));
      await _audioPlayer.seek(target);
    } catch (e) {
      print('seekTo error: $e');
    }
  }

  // Next: Load bài mới khi cần
  Future<void> playNext() async {
    if (_playlist.isEmpty) return;
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      await playSong(_playlist[_currentIndex]);
    }
  }

  // Previous: Load bài mới khi cần
  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;
    if (_currentIndex > 0) {
      _currentIndex--;
      await playSong(_playlist[_currentIndex]);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
