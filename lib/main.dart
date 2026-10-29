import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/api_config.dart';
import 'core/app_constants.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/explorer_shell.dart';
import 'services/course_service.dart';

// SEMENTARA (Tahap 2) — dihapus pada Tahap 4
Future<List<dynamic>> fetchCourses() async {
  final response = await http.get(Uri.parse('$apiBaseUrl/courses'));
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}');
  }
  return jsonDecode(response.body) as List<dynamic>;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final courses = await fetchCourses();
  debugPrint('Jumlah course: ${courses.length}');
  debugPrint('Contoh: ${courses.first}');

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(
        CourseRepository(CourseService()),
      )..loadCourses(),
      child: const MyApp(),
    ),
  );
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
      home: const ExplorerShell(),
    );
  }
}