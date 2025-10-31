import 'package:flow_up/screens/player_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> songs = [
      {
        "title": "Night Changes",
        "artist": "One Direction",
        "rating": 4.5,
        "tag": "Love",
        "image": "images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
      },
      {
        "title": "Night Changes",
        "artist": "One Direction",
        "rating": 4.5,
        "tag": "Love",
        "image": "images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
      },
      {
        "title": "Night Changes",
        "artist": "One Direction",
        "rating": 4.5,
        "tag": "Love",
        "image": "images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Popular Songs",
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
                Expanded(child: _buildTag("New", Colors.orange.shade200)),
                const SizedBox(width: 8),
                Expanded(child: _buildTag("Popular", Colors.pink.shade200)),
                const SizedBox(width: 8),
                Expanded(child: _buildTag("Trending", Colors.blue.shade200)),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 20),

            //Danh sách bài hát
            Column(
              children: songs.map((song) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(song: songs),
                      ),
                    );
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
