import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage6ScrollTest extends StatelessWidget {
  const Stage6ScrollTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 6 - Scroll & Keyboard')),
      // ===== EKSPERIMEN A: tanpa scroll (akan overflow) =====
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     children: const [
      //       CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
      //       SizedBox(height: 8),
      //       Text(studentName,
      //           style: TextStyle(fontWeight: FontWeight.bold)),
      //       Text(studentId),
      //       SizedBox(height: 16),
      //       TextField(
      //           decoration: InputDecoration(
      //               labelText: 'Nama', border: OutlineInputBorder())),
      //       SizedBox(height: 8),
      //       TextField(
      //           decoration: InputDecoration(
      //               labelText: 'NIM', border: OutlineInputBorder())),
      //       SizedBox(height: 8),
      //       TextField(
      //           decoration: InputDecoration(
      //               labelText: 'Email', border: OutlineInputBorder())),
      //       SizedBox(height: 8),
      //       TextField(
      //           maxLines: 3,
      //           decoration: InputDecoration(
      //               labelText: 'Komentar', border: OutlineInputBorder())),
      //       SizedBox(height: 8),
      //       Text(
      //           'Minat saya pada pemrograman mobile adalah membangun '
      //           'aplikasi yang responsif dan mudah digunakan.'),
      //       SizedBox(height: 8),
      //       Text(
      //           'Halaman ini sengaja dibuat lebih tinggi dari layar '
      //           'untuk menguji scrolling dan keyboard.'),
      //       SizedBox(height: 12),
      //     ],
      //   ),
      // ),

      // ===== EKSPERIMEN B: ganti body di atas dengan blok ini =====
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 8),
            Text(studentName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(studentId),
            SizedBox(height: 16),
            TextField(
                decoration: InputDecoration(
                    labelText: 'Nama', border: OutlineInputBorder())),
            SizedBox(height: 8),
            TextField(
                decoration: InputDecoration(
                    labelText: 'NIM', border: OutlineInputBorder())),
            SizedBox(height: 8),
            TextField(
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder())),
            SizedBox(height: 8),
            TextField(
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Komentar', border: OutlineInputBorder())),
            SizedBox(height: 8),
            Text(
                'Minat saya pada pemrograman mobile adalah membangun '
                'aplikasi yang responsif dan mudah digunakan.'),
            SizedBox(height: 8),
            Text(
                'Halaman ini sengaja dibuat lebih tinggi dari layar '
                'untuk menguji scrolling dan keyboard.'),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}