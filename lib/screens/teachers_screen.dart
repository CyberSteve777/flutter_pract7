import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/widgets.dart';

class TeachersScreen extends StatefulWidget {
  final DataService dataService;
  const TeachersScreen({super.key, required this.dataService});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  void _addTeacher() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final departmentController = TextEditingController();
    final positionController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить преподавателя'),
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
            TextField(
              controller: departmentController,
              decoration: const InputDecoration(labelText: 'Кафедра'),
            ),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: 'Должность'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
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
                final newTeacher = Teacher(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  email: emailController.text,
                  department: departmentController.text,
                  position: positionController.text,
                  phoneNumber: phoneController.text,
                  subjects: [],
                );
                setState(() {
                  widget.dataService.addTeacher(newTeacher);
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

  void _editTeacher(Teacher teacher) {
    final nameController = TextEditingController(text: teacher.name);
    final emailController = TextEditingController(text: teacher.email);
    final departmentController = TextEditingController(text: teacher.department);
    final positionController = TextEditingController(text: teacher.position);
    final phoneController = TextEditingController(text: teacher.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать преподавателя'),
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
            TextField(
              controller: departmentController,
              decoration: const InputDecoration(labelText: 'Кафедра'),
            ),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: 'Должность'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
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
                final updatedTeacher = Teacher(
                  id: teacher.id,
                  name: nameController.text,
                  email: emailController.text,
                  department: departmentController.text,
                  position: positionController.text,
                  phoneNumber: phoneController.text,
                  subjects: teacher.subjects,
                );
                setState(() {
                  widget.dataService.updateTeacher(updatedTeacher);
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

  void _deleteTeacher(Teacher teacher) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить преподавателя'),
        content: Text('Вы уверены, что хотите удалить ${teacher.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.dataService.deleteTeacher(teacher.id);
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
        itemCount: widget.dataService.teachers.length,
        itemBuilder: (context, index) {
          final teacher = widget.dataService.teachers[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TeacherCard(
              teacher: teacher,
              onEdit: () => _editTeacher(teacher),
              onDelete: () => _deleteTeacher(teacher),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTeacher,
        child: const Icon(Icons.add),
      ),
    );
  }
}