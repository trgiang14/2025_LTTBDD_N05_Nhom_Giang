import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> songs = [
      {
        "title": "Night Changes",
        "artist": "One Direction",
        "image": "images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
      },
      {
        "title": "Night Changes",
        "artist": "One Direction",
        "image": "images/pexels-julias-torten-und-tortchen-434418-31001122.jpg",
      },
      {
        "title": "Night Changes",
        "artist": "One Direction",
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
          "Flow Music",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  song["image"]!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                song["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(song["artist"]!),
              trailing: Icon(
                Icons.play_arrow,
                color: Colors.deepPurple.shade400,
              ),
              onTap: () {
                // chuyển sang PlayerScreen
              },
            ),
          );
        },
      ),
    );
  }
}
