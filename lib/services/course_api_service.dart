import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

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
}