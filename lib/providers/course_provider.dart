import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;
  final Set<String> _favorites = {};

  List<Course> get courses => List.unmodifiable(_courses);
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  int get favoriteCount => _favorites.length;

  List<Course> get favoriteCourses {
    return _courses
        .where((course) => _favorites.contains(course.code))
        .toList(growable: false);
  }

  Course? findById(int id) {
    for (final course in _courses) {
      if (course.id == id) {
        return course;
      }
    }
    return null;
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

  Future<String?> createCourse(Course course) async {
    if (_isSaving) return 'Permintaan lain sedang diproses.';
    _isSaving = true;
    notifyListeners();

    try {
      await repository.createCourse(course);
      await loadCourses();
      return null;
    } catch (e) {
      return 'Gagal menambah course: $e';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<String?> updateCourse(int id, Course course) async {
    if (_isSaving) return 'Permintaan lain sedang diproses.';
    _isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);
      await loadCourses();
      return null;
    } catch (e) {
      return 'Gagal memperbarui course: $e';
    } finally {
      _isSaving = false;
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
