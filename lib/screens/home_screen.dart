import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_constants.dart';
import '../providers/course_provider.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenCourses;
  final VoidCallback onOpenFavorites;

  const HomeScreen({
    super.key,
    required this.onOpenCourses,
    required this.onOpenFavorites,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final courses = provider.courses;
    final total = courses.length;
    final totalCredits = courses.fold<int>(
      0,
      (sum, course) => sum + course.credits,
    );
    final doneCount = courses.where((course) => course.isDone).length;
    final favoriteCount = provider.favoriteCount;
    final progress = total == 0 ? 0.0 : doneCount / total;

    return RefreshIndicator(
      onRefresh: provider.loadCourses,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const _IdentityCard(),
          const SizedBox(height: 12),
          if (provider.isLoading && courses.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (provider.error != null && courses.isEmpty)
            _ErrorCard(
              message: provider.error!,
              onRetry: provider.loadCourses,
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    value: '$total',
                    label: 'Topik',
                    icon: Icons.widgets_outlined,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    value: '$totalCredits',
                    label: 'Total SKS',
                    icon: Icons.school_outlined,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    value: '$doneCount',
                    label: 'Selesai',
                    icon: Icons.check_circle_outline,
                  ),
                ),
                Expanded(
                  child: StatCard(
                    value: '$favoriteCount',
                    label: 'Favorit',
                    icon: Icons.favorite_border,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$doneCount dari $total topik selesai',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: progress),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onOpenCourses,
                    icon: const Icon(Icons.school),
                    label: const Text('Lihat Courses'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onOpenFavorites,
                    icon: const Icon(Icons.favorite),
                    label: Text('Favorites ($favoriteCount)'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return Card(
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
            const SizedBox(height: 4),
            Text(
              appTitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () => onRetry(),
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}