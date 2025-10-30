import "package:flutter/material.dart";

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "About us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.music_note, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text(
                "Flow Up Music Player",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ứng dụng phát nhạc được phát triển bằng Flutter.\n"
                "Hỗ trợ nghe nhạc, có giao diện sáng/tối, đa ngôn ngữ và phát nhạc trực tiếp.\n\n"
                "Thành viên nhóm:\n"
                "Trần Thị Thu Giang \n"
                "@ 2025 Flow Up Team",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
