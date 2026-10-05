import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

final List<Map<String, dynamic>> courses = [
  {'code': 'MOB01', 'title': 'Git & GitHub', 'credits': 2, 'status': 'done'},
  {'code': 'MOB02', 'title': 'Dart Fundamentals', 'credits': 2, 'status': 'done'},
  {'code': 'MOB03', 'title': 'Flutter UI Fundamentals', 'credits': 3, 'status': 'active'},
  {'code': 'MOB04', 'title': 'Navigation', 'credits': 2, 'status': 'planned'},
  {'code': 'MOB05', 'title': 'State Management', 'credits': 3, 'status': 'planned'},
];

class Stage8CourseList extends StatelessWidget {
  const Stage8CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 8 - Course List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: const [
                Text(studentName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(studentId),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(course['title'] as String),
                    subtitle: Text(course['code'] as String),
                    trailing:
                        const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CourseDetailPage(course: course),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course['title'] as String)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title'] as String,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Kode: ${course['code']}'),
            Text('SKS: ${course['credits']}'),
            Text('Status: ${course['status']}'),
            const Divider(height: 24),
            const Text('Pemilik aplikasi:'),
            Text('$studentId - $studentName',
                style:
                    const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}