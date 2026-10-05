import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage2MediaQueryTest extends StatelessWidget {
  const Stage2MediaQueryTest({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final String kategori = size.width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 2 - MediaQuery')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              studentName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(studentId),
            const SizedBox(height: 16),
            Text('Width: ${size.width.toStringAsFixed(0)}'),
            Text('Height: ${size.height.toStringAsFixed(0)}'),
            Text('Orientation: $orientation'),
            const SizedBox(height: 8),
            Text(
              'Kategori: $kategori',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}