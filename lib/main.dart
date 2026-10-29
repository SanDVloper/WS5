import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'core/api_config.dart';
import 'core/app_constants.dart';
import 'models/course.dart';

// SEMENTARA (Tahap 3) — dihapus pada Tahap 4
Future<List<Course>> loadCourseModels() async {
  final response = await http.get(Uri.parse('$apiBaseUrl/courses'));
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}');
  }
  final data = jsonDecode(response.body) as List<dynamic>;
  return data
      .map((item) => Course.fromJson(item as Map<String, dynamic>))
      .toList();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const _TempCourseList(),
    );
  }
}

// SEMENTARA (Tahap 3) — menampilkan 3 course hasil mapping JSON ke model
class _TempCourseList extends StatefulWidget {
  const _TempCourseList();

  @override
  State<_TempCourseList> createState() => _TempCourseListState();
}

class _TempCourseListState extends State<_TempCourseList> {
  late Future<List<Course>> _future;

  @override
  void initState() {
    super.initState();
    _future = loadCourseModels();
  }

  void _reload() {
    setState(() {
      _future = loadCourseModels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tahap 3 — Model Course'),
            Text(
              '$studentName • $studentId',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Course>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Gagal memuat data:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final allCourses = snapshot.data ?? [];
          if (allCourses.isEmpty) {
            return const Center(child: Text('Data course belum tersedia'));
          }

          final courses = allCourses.take(3).toList();

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Text(
                'Menampilkan ${courses.length} dari ${allCourses.length} course',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...courses.map((course) {
                final color = course.isDone
                    ? Colors.green
                    : (course.isActive ? Colors.blue : Colors.grey);
                final icon = course.isDone
                    ? Icons.check_circle
                    : (course.isActive
                        ? Icons.play_circle_fill
                        : Icons.schedule);

                return Card(
                  child: ListTile(
                    leading: Icon(icon, color: color),
                    title: Text(course.title),
                    subtitle: Text(
                      '${course.code} • ${course.credits} SKS • id ${course.id}',
                    ),
                    trailing: Text(
                      course.statusLabel,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}