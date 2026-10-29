import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await _client.from('courses').select().order('id');
    return (data as List)
        .map((row) => Course.fromJson(row as Map<String, dynamic>))
        .toList(growable: false);
  }

  // Sementara, agar kelas tetap dapat dikompilasi.
  @override
  Future<Course> createCourse(Course course) =>
      throw UnimplementedError('createCourse belum diimplementasikan');

  @override
  Future<void> updateCourse(int id, Course course) =>
      throw UnimplementedError('updateCourse belum diimplementasikan');

  @override
  Future<void> deleteCourse(int id) =>
      throw UnimplementedError('deleteCourse belum diimplementasikan');
}
