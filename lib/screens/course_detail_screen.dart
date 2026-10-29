import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_constants.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import 'course_form_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final current = course.id == null
        ? course
        : (provider.findById(course.id!) ?? course);
    final isFavorite = provider.isFavorite(current.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(current.title),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Hapus dari favorit' : 'Tandai favorit',
            onPressed: () => context
                .read<CourseProvider>()
                .toggleFavorite(current.code),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(label: 'ID', value: current.id?.toString() ?? '-'),
                    _InfoRow(label: 'Kode', value: current.code),
                    _InfoRow(label: 'SKS', value: '${current.credits}'),
                    _InfoRow(label: 'Status', value: current.statusLabel),
                    const SizedBox(height: 12),
                    Chip(
                      avatar: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color: isFavorite ? Colors.red : null,
                      ),
                      label: Text(
                        isFavorite ? 'Favorit' : 'Belum favorit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context
                    .read<CourseProvider>()
                    .toggleFavorite(current.code),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  isFavorite ? 'Hapus dari Favorit' : 'Tandai Favorit',
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: current.id == null || provider.isSaving
                    ? null
                    : () => _openEdit(context, current),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Course'),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              '$studentId - $studentName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _openEdit(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseFormScreen(course: course),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
