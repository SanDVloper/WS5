import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/api_config.dart';
import 'core/app_constants.dart';
import 'core/supabase_config.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/explorer_shell.dart';
import 'services/course_api_service.dart';
import 'services/course_data_source.dart';
import 'services/course_supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isSupabaseConfigured) {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabasePublishableKey,
    );
  } else {
    debugPrint(
      'Supabase belum dikonfigurasi. '
      'Isi lib/core/supabase_config.dart terlebih dahulu.',
    );
  }

  final CourseDataSource dataSource = isSupabaseConfigured
      ? CourseSupabaseService()
      : CourseApiService(apiBaseUrl);
  debugPrint('DataSource: ${dataSource.runtimeType}');
  final repository = CourseRepository(dataSource);

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
