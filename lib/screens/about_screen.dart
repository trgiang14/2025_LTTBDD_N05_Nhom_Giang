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
          "Flow Up Music Player ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Ảnh đại diện
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),

                const SizedBox(height: 20),

                // Tên
                const Text(
                  'Trần Thu Giang',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // Vai trò
                const Text(
                  'Developer / UI Designer',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const Divider(height: 40),

                // Mô tả ngắn
                const Text(
                  'Xin chào! Tôi là Giang, hiện đang phát triển ứng dụng '
                  'FlowUp — một trình phát nhạc đơn giản, hiện đại và dễ sử dụng.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),

                const SizedBox(height: 30),

                // Liên hệ
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('giang@example.com'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
