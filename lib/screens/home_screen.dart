import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../utils/ru_plural.dart';
import 'students_screen.dart';
import 'courses_screen.dart';
import 'teachers_screen.dart';
import 'grades_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Образовательная система'),
      ),
      body: _buildDashboard(context, dataService),
    );
  }

  Widget _buildMenuCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      String subtitle,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, DataService dataService) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildMenuCard(
            context,
            'Студенты',
            Icons.people,
            Colors.blue,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentsScreen(dataService: dataService),
                ),
              );
            },
            formatCount(dataService.students.length, 'студент', 'студента', 'студентов'),
          ),
          _buildMenuCard(
            context,
            'Курсы',
            Icons.school,
            Colors.green,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CoursesScreen(dataService: dataService),
                ),
              );
            },
            formatCount(dataService.courses.length, 'курс', 'курса', 'курсов'),
          ),
          _buildMenuCard(
            context,
            'Преподаватели',
            Icons.person,
            Colors.orange,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TeachersScreen(dataService: dataService),
                ),
              );
            },
            formatCount(dataService.teachers.length, 'преподаватель', 'преподавателя', 'преподавателей'),
          ),
          _buildMenuCard(
            context,
            'Оценки',
            Icons.grade,
            Colors.purple,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GradesScreen(dataService: dataService),
                ),
              );
            },
            formatCount(dataService.grades.length, 'оценка', 'оценки', 'оценок'),
          ),
        ],
      ),
    );
  }
}
