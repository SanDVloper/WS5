import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage3BreakpointTest extends StatelessWidget {
  const Stage3BreakpointTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 3 - Breakpoint')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const CompactLayout();
          } else if (constraints.maxWidth < 840) {
            return const MediumLayout();
          } else {
            return const ExpandedLayout();
          }
        },
      ),
    );
  }
}

class CompactLayout extends StatelessWidget {
  const CompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade200,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.phone_android, size: 64),
            SizedBox(height: 8),
            Text(studentName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(studentId),
            Text('Compact (< 600)'),
          ],
        ),
      ),
    );
  }
}

class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade200,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.tablet_android, size: 64),
            SizedBox(height: 8),
            Text(studentName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(studentId),
            Text('Medium (600 - 839)'),
          ],
        ),
      ),
    );
  }
}

class ExpandedLayout extends StatelessWidget {
  const ExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade200,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          const Icon(Icons.desktop_windows, size: 64),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(studentName,
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(studentId),
              Text('Expanded (>= 840)'),
            ],
          ),
        ],
      ),
    );
  }
}