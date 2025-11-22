class Student {
  final String id;
  final String name;
  final String email;
  final List<String> enrolledCourses;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.enrolledCourses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'enrolledCourses': enrolledCourses,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      enrolledCourses: List<String>.from(map['enrolledCourses'] ?? []),
    );
  }
}