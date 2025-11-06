import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HssBleApp());
}

class HssBleApp extends StatelessWidget {
  const HssBleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSS LoRa Control',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}