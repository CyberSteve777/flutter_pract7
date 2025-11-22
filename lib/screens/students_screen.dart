import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/widgets.dart';

class StudentsScreen extends StatefulWidget {
  final DataService dataService;
  const StudentsScreen({super.key, required this.dataService});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  void _addStudent() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить студента'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'ФИО'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Электронная почта'),
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
              if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                final newStudent = Student(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  email: emailController.text,
                  enrolledCourses: [],
                );
                setState(() {
                  widget.dataService.addStudent(newStudent);
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

  void _editStudent(Student student) {
    final nameController = TextEditingController(text: student.name);
    final emailController = TextEditingController(text: student.email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать студента'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'ФИО'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Электронная почта'),
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
              if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                final updatedStudent = Student(
                  id: student.id,
                  name: nameController.text,
                  email: emailController.text,
                  enrolledCourses: student.enrolledCourses,
                );
                setState(() {
                  widget.dataService.updateStudent(updatedStudent);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить студента'),
        content: Text('Вы уверены, что хотите удалить ${student.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.dataService.deleteStudent(student.id);
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
        itemCount: widget.dataService.students.length,
        itemBuilder: (context, index) {
          final student = widget.dataService.students[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: StudentCard(
              student: student,
              onEdit: () => _editStudent(student),
              onDelete: () => _deleteStudent(student),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
