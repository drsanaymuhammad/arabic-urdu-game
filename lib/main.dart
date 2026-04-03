// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ArabicUrduGameApp());
}

class ArabicUrduGameApp extends StatelessWidget {
  const ArabicUrduGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قرآنی الفاظ گیم',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A3B8C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'NooriFont',
      ),
      home: const HomeScreen(),
    );
  }
}
