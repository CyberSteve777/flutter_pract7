import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../utils/ru_plural.dart';
import 'students_screen.dart';
import 'courses_screen.dart';
import 'teachers_screen.dart';
import 'grades_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Section { dashboard, students, courses, teachers, grades }

class _HomeScreenState extends State<HomeScreen> {
  final DataService dataService = DataService();
  _Section _section = _Section.dashboard;

  @override
  Widget build(BuildContext context) {
    final title = switch (_section) {
      _Section.dashboard => 'Образовательная система',
      _Section.students => 'Студенты',
      _Section.courses => 'Курсы',
      _Section.teachers => 'Преподаватели',
      _Section.grades => 'Оценки',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: _section == _Section.dashboard
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _section = _Section.dashboard),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildMenuCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      _Section target,
      String subtitle,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => setState(() => _section = target),
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

  Widget _buildBody() {
    switch (_section) {
      case _Section.dashboard:
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
                _Section.students,
                formatCount(dataService.students.length, 'студент', 'студента',
                    'студентов'),
              ),
              _buildMenuCard(
                context,
                'Курсы',
                Icons.school,
                Colors.green,
                _Section.courses,
                formatCount(
                    dataService.courses.length, 'курс', 'курса', 'курсов'),
              ),
              _buildMenuCard(
                context,
                'Преподаватели',
                Icons.person,
                Colors.orange,
                _Section.teachers,
                formatCount(dataService.teachers.length, 'преподаватель',
                    'преподавателя', 'преподавателей'),
              ),
              _buildMenuCard(
                context,
                'Оценки',
                Icons.grade,
                Colors.purple,
                _Section.grades,
                formatCount(
                    dataService.grades.length, 'оценка', 'оценки', 'оценок'),
              ),
            ],
          ),
        );
      case _Section.students:
        return StudentsScreen(dataService: dataService);
      case _Section.courses:
        return CoursesContent(dataService: dataService);
      case _Section.teachers:
        return TeachersScreen(dataService: dataService);
      case _Section.grades:
        return GradesScreen(dataService: dataService);
    }
  }
}
