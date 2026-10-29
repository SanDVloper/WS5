import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/api_config.dart';
import 'core/app_constants.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/explorer_shell.dart';
import 'services/course_api_service.dart';

void main() {
  final repository = CourseRepository(CourseApiService(apiBaseUrl));
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(repository)..loadCourses(),
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