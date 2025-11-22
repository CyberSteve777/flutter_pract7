import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/data_service.dart';
import '../widgets/widgets.dart';

class GradesScreen extends StatefulWidget {
  final DataService dataService;
  const GradesScreen({super.key, required this.dataService});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  void _addGrade() {
    final gradeController = TextEditingController();
    String selectedStudentId = '';
    String selectedCourseId = '';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Добавить оценку'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedStudentId.isEmpty ? null : selectedStudentId,
                hint: const Text('Выберите студента'),
                items: widget.dataService.students.map((student) {
                  return DropdownMenuItem(
                    value: student.id,
                    child: Text(student.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStudentId = value ?? '';
                  });
                },
              ),
              DropdownButton<String>(
                value: selectedCourseId.isEmpty ? null : selectedCourseId,
                hint: const Text('Выберите курс'),
                items: widget.dataService.courses.map((course) {
                  return DropdownMenuItem(
                    value: course.id,
                    child: Text(course.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCourseId = value ?? '';
                  });
                },
              ),
              TextField(
                controller: gradeController,
                decoration: const InputDecoration(labelText: 'Оценка (0–100)'),
                keyboardType: TextInputType.number,
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
                final grade = double.tryParse(gradeController.text);
                if (selectedStudentId.isNotEmpty && selectedCourseId.isNotEmpty && grade != null) {
                  final newGrade = Grade(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    studentId: selectedStudentId,
                    courseId: selectedCourseId,
                    grade: grade,
                    date: DateTime.now(),
                    comments: '',
                  );
                  this.setState(() {
                    widget.dataService.addGrade(newGrade);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }

  void _editGrade(Grade grade) {
    final gradeController = TextEditingController(text: grade.grade.toString());
    final commentsController = TextEditingController(text: grade.comments ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать оценку'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: gradeController,
              decoration: const InputDecoration(labelText: 'Оценка (0–100)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: commentsController,
              decoration: const InputDecoration(labelText: 'Комментарий'),
              maxLines: 3,
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
              final newGrade = double.tryParse(gradeController.text);
              if (newGrade != null) {
                final updatedGrade = Grade(
                  id: grade.id,
                  studentId: grade.studentId,
                  courseId: grade.courseId,
                  grade: newGrade,
                  date: grade.date,
                  comments: commentsController.text,
                );
                setState(() {
                  widget.dataService.updateGrade(updatedGrade);
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

  void _deleteGrade(Grade grade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить оценку'),
        content: const Text('Вы уверены, что хотите удалить эту оценку?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.dataService.deleteGrade(grade.id);
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
        itemCount: widget.dataService.grades.length,
        itemBuilder: (context, index) {
          final grade = widget.dataService.grades[index];
          final student = widget.dataService.students.firstWhere(
                (s) => s.id == grade.studentId,
            orElse: () => Student(id: '', name: 'Неизвестно', email: '', enrolledCourses: const []),
          );
          final course = widget.dataService.courses.firstWhere(
                (c) => c.id == grade.courseId,
            orElse: () => Course(id: '', name: 'Неизвестно', code: '', credits: 0, teacherId: ''),
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GradeCard(
              grade: grade,
              student: student,
              course: course,
              onEdit: () => _editGrade(grade),
              onDelete: () => _deleteGrade(grade),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGrade,
        child: const Icon(Icons.add),
      ),
    );
  }
}
