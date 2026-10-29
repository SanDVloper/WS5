import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = course.isDone;
    final statusColor = isDone
        ? Colors.green
        : (course.isActive ? Colors.blue : Colors.grey);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    isDone ? Icons.check_circle : Icons.circle_outlined,
                    color: statusColor,
                  ),
                  const Spacer(),
                  Consumer<CourseProvider>(
                    builder: (context, provider, child) {
                      final isFavorite = provider.isFavorite(course.code);
                      return IconButton(
                        tooltip: isFavorite
                            ? 'Hapus dari favorit'
                            : 'Tandai favorit',
                        visualDensity: VisualDensity.compact,
                        onPressed: () => context
                            .read<CourseProvider>()
                            .toggleFavorite(course.code),
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                course.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text('${course.code} • ${course.credits} SKS'),
              const SizedBox(height: 4),
              Text(
                course.statusLabel,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}