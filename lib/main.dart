import 'package:flutter/material.dart';
import 'screens/player_screen.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(FlowApp());
}

class FlowApp extends StatefulWidget {
  const FlowApp({super.key});

  @override
  State<FlowApp> createState() => _FlowAppState();
}

class _FlowAppState extends State<FlowApp> {
  int _selectedIndex = 0;

  //Danh sách các trang
  final List<Widget> _screen = const [
    HomeScreen(),
    PlayerScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flow Up Music Player",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Player',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
