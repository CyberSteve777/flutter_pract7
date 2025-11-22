import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/students_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/teachers_screen.dart';
import 'screens/grades_screen.dart';
import 'services/data_service.dart';

void main() {
  runApp(const EducationalSystemApp());
}

class EducationalSystemApp extends StatelessWidget {
  const EducationalSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();

    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const AuthorizationScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(dataService: dataService),
        ),
        GoRoute(
          path: '/students',
          builder: (context, state) => StudentsScreen(dataService: dataService),
        ),
        GoRoute(
          path: '/courses',
          builder: (context, state) => CoursesScreen(dataService: dataService),
        ),
        GoRoute(
          path: '/teachers',
          builder: (context, state) => TeachersScreen(dataService: dataService),
        ),
        GoRoute(
          path: '/grades',
          builder: (context, state) => GradesScreen(dataService: dataService),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Образовательная система',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
