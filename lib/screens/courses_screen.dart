import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/widgets.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final DataService dataService = DataService();

  void _addCourse() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();
    final creditsController = TextEditingController();
    final teacherIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить курс'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название курса'),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Код курса'),
            ),
            TextField(
              controller: creditsController,
              decoration: const InputDecoration(labelText: 'Часы'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: teacherIdController,
              decoration: const InputDecoration(labelText: 'ID преподавателя'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  codeController.text.isNotEmpty) {
                final newCourse = Course(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  code: codeController.text,
                  credits: int.tryParse(creditsController.text) ?? 3,
                  teacherId: teacherIdController.text,
                );
                setState(() {
                  dataService.addCourse(newCourse);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _enrollStudent(Course course) {
    final studentIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Записать студента'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Курс: ${course.name}'),
            TextField(
              controller: studentIdController,
              decoration: const InputDecoration(labelText: 'ID студента'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (studentIdController.text.isNotEmpty) {
                setState(() {
                  dataService.enrollStudentInCourse(
                    course.id,
                    studentIdController.text,
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Записать'),
          ),
        ],
      ),
    );
  }

  void _deleteCourse(Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить курс'),
        content: Text('Вы уверены, что хотите удалить ${course.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                dataService.deleteCourse(course.id);
              });
              Navigator.pop(context);
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dataService.courses.length,
        itemBuilder: (context, index) {
          final course = dataService.courses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CourseCard(
              course: course,
              teacher: dataService.teachers.firstWhere(
                (t) => t.id == course.teacherId,
              ),
              onEnrollStudent: () => _enrollStudent(course),
              onEdit: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Находится в разработке...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              onDelete: () => _deleteCourse(course),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Встраиваемый контент курсов без собственного AppBar
class CoursesContent extends StatefulWidget {
  final DataService dataService;

  const CoursesContent({super.key, required this.dataService});

  @override
  State<CoursesContent> createState() => _CoursesContentState();
}

class _CoursesContentState extends State<CoursesContent> {
  void _addCourse() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();
    final creditsController = TextEditingController();
    final teacherIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить курс'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название курса'),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Код курса'),
            ),
            TextField(
              controller: creditsController,
              decoration: const InputDecoration(labelText: 'Часы'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: teacherIdController,
              decoration: const InputDecoration(labelText: 'ID преподавателя'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  codeController.text.isNotEmpty) {
                final newCourse = Course(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  code: codeController.text,
                  credits: int.tryParse(creditsController.text) ?? 3,
                  teacherId: teacherIdController.text,
                );
                setState(() {
                  widget.dataService.addCourse(newCourse);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _enrollStudent(Course course) {
    final studentIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Записать студента'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Курс: ${course.name}'),
            TextField(
              controller: studentIdController,
              decoration: const InputDecoration(labelText: 'ID студента'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (studentIdController.text.isNotEmpty) {
                setState(() {
                  widget.dataService.enrollStudentInCourse(
                    course.id,
                    studentIdController.text,
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Записать'),
          ),
        ],
      ),
    );
  }

  void _deleteCourse(Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить курс'),
        content: Text('Вы уверены, что хотите удалить ${course.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.dataService.deleteCourse(course.id);
              });
              Navigator.pop(context);
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.dataService.courses.length,
        itemBuilder: (context, index) {
          final course = widget.dataService.courses[index];
          final teacher = widget.dataService.teachers.firstWhere(
            (t) => t.id == course.teacherId,
            orElse: () => Teacher(
              id: '',
              name: 'Неизвестно',
              email: '',
              department: '',
              position: '',
              phoneNumber: '',
              subjects: const [],
            ),
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CourseCard(
              course: course,
              teacher: teacher,
              onEnrollStudent: () => _enrollStudent(course),
              onEdit: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Находится в разработке...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              onDelete: () => _deleteCourse(course),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}
