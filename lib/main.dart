import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
// Named routes removed; only HomeScreen is needed here.

void main() {
  runApp(const EducationalSystemApp());
}

class EducationalSystemApp extends StatelessWidget {
  const EducationalSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Образовательная система',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        // Remove cardTheme to avoid type mismatch across Flutter versions
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
