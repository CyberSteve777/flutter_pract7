import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/data_service.dart';
import '../utils/ru_plural.dart';

class HomeScreen extends StatelessWidget {
  final DataService dataService;
  const HomeScreen({super.key, required this.dataService});

  @override
  Widget build(BuildContext context) {
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
            () => context.push('/students'),
            formatCount(dataService.students.length, 'студент', 'студента', 'студентов'),
          ),
          _buildMenuCard(
            context,
            'Курсы',
            Icons.school,
            Colors.green,
            () => context.push('/courses'),
            formatCount(dataService.courses.length, 'курс', 'курса', 'курсов'),
          ),
          _buildMenuCard(
            context,
            'Преподаватели',
            Icons.person,
            Colors.orange,
            () => context.push('/teachers'),
            formatCount(dataService.teachers.length, 'преподаватель', 'преподавателя', 'преподавателей'),
          ),
          _buildMenuCard(
            context,
            'Оценки',
            Icons.grade,
            Colors.purple,
            () => context.push('/grades'),
            formatCount(dataService.grades.length, 'оценка', 'оценки', 'оценок'),
          ),
        ],
      ),
    );
  }
}
