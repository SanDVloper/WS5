import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

// Collection course dari pertemuan sebelumnya
final List<Map<String, dynamic>> courses = [
  {'code': 'MOB01', 'title': 'Git & GitHub', 'credits': 2, 'status': 'done'},
  {'code': 'MOB02', 'title': 'Dart Fundamentals', 'credits': 2, 'status': 'done'},
  {'code': 'MOB03', 'title': 'Flutter UI Fundamentals', 'credits': 3, 'status': 'active'},
  {'code': 'MOB04', 'title': 'Navigation', 'credits': 2, 'status': 'planned'},
  {'code': 'MOB05', 'title': 'State Management', 'credits': 3, 'status': 'planned'},
];

int columnsFor(double width) {
  if (width < 600) return 1;
  if (width < 840) return 2;
  return 3;
}

class Stage5GridTest extends StatelessWidget {
  const Stage5GridTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 5 - Grid Responsif')),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        columnsFor(constraints.maxWidth),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) =>
                      CourseCard(course: courses[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final bool isDone = course['status'] == 'done';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.circle_outlined,
              color: isDone ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              course['title'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${course['code']} • ${course['credits']} SKS'),
          ],
        ),
      ),
    );
  }
}