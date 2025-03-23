import 'package:flutter/material.dart';
import 'home_page.dart'; // 匯入封裝後的 HomePage

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(), // 使用封裝後的 HomePage
    );
  }
}
