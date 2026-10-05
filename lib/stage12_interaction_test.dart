import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage12Interaction extends StatefulWidget {
  const Stage12Interaction({super.key});

  @override
  State<Stage12Interaction> createState() =>
      _Stage12InteractionState();
}

class _Stage12InteractionState extends State<Stage12Interaction> {
  bool isFavorite = false;
  int tapCount = 0;

  static const Map<String, dynamic> course = {
    'code': 'MOB03',
    'title': 'Flutter UI Fundamentals',
    'credits': 3,
    'status': 'active',
  };

  void _showInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${course['code']} • ${course['credits']} SKS • ${course['status']}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 12 - Interaction')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(studentName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(studentId),
          Text('Jumlah tap: $tapCount'),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              setState(() => tapCount++);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Tap ke-$tapCount: ${course['title']}')),
              );
            },
            onLongPress: _showInfo,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(course['title'] as String),
                subtitle: Text(course['code'] as String),
                trailing: IconButton(
                  tooltip: 'Favorite',
                  onPressed: () {
                    setState(
                        () => isFavorite = !isFavorite);
                  },
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
              'Coba: ketuk kartu (tap + ripple), tahan kartu '
              '(long press info), tekan hati (favorite).'),
        ],
      ),
    );
  }
}