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

  // Audio source tổng
  ConcatenatingAudioSource? _audioSource;

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
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  // Chuẩn bị playlist để load sẵn các bài
  Future<void> setPlaylist(
    List<Map<String, dynamic>> playlist, {
    int startIndex = 0,
  }) async {
    _playlist = playlist;
    _currentIndex = startIndex;

    final sources = playlist.map((song) {
      final url = song['url'] ?? '';
      if (url.startsWith('assets/')) {
        return AudioSource.asset(url);
      } else if (url.startsWith('asset://')) {
        return AudioSource.asset(url.replaceFirst('asset://', 'assets/'));
      } else if (url.startsWith('http')) {
        return AudioSource.uri(Uri.parse(url));
      } else {
        return AudioSource.file(url);
      }
    }).toList();

    _audioSource = ConcatenatingAudioSource(children: sources);

    await _audioPlayer.setAudioSource(
      _audioSource!,
      initialIndex: startIndex,
      preload: true,
    );

    _currentSong = _playlist[startIndex];
    notifyListeners();
  }

  // Phát bài
  Future<void> playSong(
    Map<String, dynamic> song, {
    List<Map<String, dynamic>>? playlist,
    int? index,
  }) async {
    if (playlist != null) {
      await setPlaylist(playlist, startIndex: index ?? 0);
    } else if (_audioSource == null) {
      await setPlaylist([song]);
    }

    await _audioPlayer.play();
    _currentSong = song;
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  // Tua nhạc
  Future<void> seekTo(int seconds) async {
    final total = _audioPlayer.duration ?? Duration.zero;
    if (total == Duration.zero) return;
    final target = Duration(seconds: seconds.clamp(0, total.inSeconds));
    await _audioPlayer.seek(target);
  }

  // Chuyển bài
  Future<void> playNext() async {
    if (_playlist.isEmpty) return;
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      await _audioPlayer.seekToNext();
      await _audioPlayer.play();
      _currentSong = _playlist[_currentIndex];
      notifyListeners();
    }
  }

  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;
    if (_currentIndex > 0) {
      _currentIndex--;
      await _audioPlayer.seekToPrevious();
      await _audioPlayer.play();
      _currentSong = _playlist[_currentIndex];
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
