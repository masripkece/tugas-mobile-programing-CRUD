import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MenabungApp());
}

class MenabungApp extends StatelessWidget {
  const MenabungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}
