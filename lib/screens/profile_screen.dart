import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_constants.dart';
import '../providers/course_provider.dart';
import '../widgets/feedback_form.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCount = context.watch<CourseProvider>().favoriteCount;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  child: Icon(Icons.person, size: 36),
                ),
                const SizedBox(height: 8),
                const Text(
                  studentName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(studentId),
                const SizedBox(height: 8),
                const Text('PTI 5 IKI • Mobile Programming'),
                const SizedBox(height: 8),
                Chip(label: Text('$favoriteCount course favorit')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const FeedbackForm(),
      ],
    );
  }
}