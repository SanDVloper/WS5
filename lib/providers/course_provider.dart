import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _error;
  final Set<String> _favorites = {};

  List<Course> get courses => List.unmodifiable(_courses);
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get favoriteCount => _favorites.length;

  List<Course> get favoriteCourses {
    return _courses
        .where((course) => _favorites.contains(course.code))
        .toList(growable: false);
  }

  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (e) {
      _error = 'Gagal memuat data course: $e';
      _courses = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String code) => _favorites.contains(code);

  void toggleFavorite(String code) {
    if (!_favorites.add(code)) {
      _favorites.remove(code);
    }
    notifyListeners();
  }
}