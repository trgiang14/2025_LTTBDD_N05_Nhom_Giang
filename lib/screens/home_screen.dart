import 'package:flow_up/screens/player_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flow_up/lang.dart';
import '../services/music_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> songs = [
      {
        "title": "Night Changes",
        "artist": "One Direction",
        "rating": 4.5,
        "tag": "Love",
        "url": "assets/audios/Night Changes.mp3",
        "image":
            "assets/images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
      },
      {
        "title": "Alive",
        "artist": "Cristina Vee",
        "rating": 4.5,
        "tag": "Unknown",
        "url": "assets/audios/塞壬唱片 - A WORLD FAMILIARLY Alive.mp3",
        "image": "assets/images/7d9ab6167720f8f4b982c83fbe89ce0b.jpg",
      },
      {
        "title": "Still the same",
        "artist": "Adam Gubman & Chad Reisser",
        "rating": 4.5,
        "tag": "Unknown",
        "url": "assets/audios/塞壬唱片 - A WORLD FAMILIARLY Still the save.wav",
        "image": "assets/images/94db0d0ca72b66977653601d53447fcc.jpg",
      },
    ];
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Flow Up Music Player ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          DropdownButton(
            value: currentLanguage,
            items: const [
              DropdownMenuItem(value: "en", child: Text("EN")),
              DropdownMenuItem(value: "vi", child: Text("VI")),
            ],
            onChanged: (String? name) {
              setState(() {
                currentLanguage = name ?? "en";
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                lang("popular_songs", "Popular Songs"),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            //Thanh tag lọc
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildTag(lang("new", "New"), Colors.orange.shade200),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTag(
                    lang("popular", "Popular"),
                    Colors.pink.shade200,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTag(
                    lang("trending", "Trending"),
                    Colors.blue.shade200,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 20),

            //Danh sách bài hát
            Column(
              children: songs.asMap().entries.map((entry) {
                final index = entry.key;
                final song = entry.value;

                return GestureDetector(
                  onTap: () {
                    final musicService = Provider.of<MusicService>(
                      context,
                      listen: false,
                    );
                    musicService.playSong(song, playlist: songs, index: index);
                    DefaultTabController.of(context)?.animateTo(1);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          song["image"],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        song["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${song["artist"]}'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text('${song["rating"]}'),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${song["tag"]}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.play_arrow,
                        color: Colors.deepPurple.shade400,
                        size: 28,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

//Hàm tạo widget tag nhỏ
Widget _buildTag(String label, Color color) {
  return Container(
    alignment: Alignment.center,
    height: 36,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
  );
}
