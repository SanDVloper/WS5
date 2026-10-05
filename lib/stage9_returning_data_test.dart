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

class Stage9CourseList extends StatefulWidget {
  const Stage9CourseList({super.key});

  @override
  State<Stage9CourseList> createState() =>
      _Stage9CourseListState();
}

class _Stage9CourseListState extends State<Stage9CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 9 - Returning Data')),
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
                    title: Text(course['title'] as String),
                    subtitle: Text(course['code'] as String),
                    trailing:
                        const Icon(Icons.chevron_right),
                    onTap: () async {
                      final result =
                          await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Stage9Detail(course: course),
                        ),
                      );
                      if (result == true) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                                '${course['title']} ditandai favorit'),
                          ),
                        );
                      }
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

class Stage9Detail extends StatelessWidget {
  final Map<String, dynamic> course;

  const Stage9Detail({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course['title'] as String)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$studentId - $studentName',
                style:
                    const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(course['title'] as String),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Pilih / Favorite'),
            ),
          ],
        ),
      ),
    );
  }
}