import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

const List<String> skills = [
  'Flutter',
  'Dart',
  'Git',
  'Firebase',
  'UI Design',
  'REST API',
  'Testing',
];

class Stage4FlexWrapTest extends StatelessWidget {
  const Stage4FlexWrapTest({super.key});

  Widget buildBox(String label, Color color) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      color: color,
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 4 - Flex & Wrap')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(studentName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(studentId),
            const SizedBox(height: 16),
            const Text('Expanded flex 2 : 1'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(flex: 2, child: buildBox('A (2)', Colors.indigo)),
                const SizedBox(width: 8),
                Expanded(child: buildBox('B (1)', Colors.teal)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Wrap Chips (otomatis pindah baris)'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  skills.map((e) => Chip(label: Text(e))).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Row biasa (overflow saat ruang sempit)'),
            const SizedBox(height: 8),
            Row(
              children: skills
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(label: Text(e)),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}