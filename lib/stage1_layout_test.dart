import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage1LayoutTest extends StatelessWidget {
  const Stage1LayoutTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 1 - Layout Test')),
      // ===== EKSPERIMEN A: width hard-coded 500 (overflow di HP) =====
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(16),
          color: Colors.amber.shade200,
          child: Text('$studentId - $studentName'),
        ),
      ),

      // ===== EKSPERIMEN B: ganti body di atas dengan blok ini =====
      // body: Center(
      //   child: Container(
      //     width: double.infinity,
      //     margin: const EdgeInsets.all(16),
      //     padding: const EdgeInsets.all(16),
      //     color: Colors.green.shade200,
      //     child: Text('$studentId - $studentName'),
      //   ),
      // ),

      // ===== EKSPERIMEN C: ganti body di atas dengan blok ini =====
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           padding: const EdgeInsets.all(16),
      //           color: Colors.blue.shade200,
      //           child: Text('$studentId - $studentName'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}