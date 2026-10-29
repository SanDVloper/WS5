import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  @override
  Future<List<Course>> getCourses() async {
    final response = await http.get(_uri('/courses'));
    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course (HTTP ${response.statusCode})');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Course.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Course> createCourse(Course course) async {
    final response = await http.post(
      _uri('/courses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal membuat course (HTTP ${response.statusCode})');
    }
    return Course.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    final response = await http.put(
      _uri('/courses/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal memperbarui course (HTTP ${response.statusCode})',
      );
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(_uri('/courses/$id'));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal menghapus course (HTTP ${response.statusCode})');
    }
  }
}
