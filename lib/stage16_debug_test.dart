import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage16Debug extends StatefulWidget {
  const Stage16Debug({super.key});

  @override
  State<Stage16Debug> createState() => _Stage16DebugState();
}

class _Stage16DebugState extends State<Stage16Debug> {
  bool _navigating = false;
  int pushCount = 0;

  Future<void> _openDetail() async {
    if (_navigating) return; // PENJAGA D: hapus baris ini untuk reproduksi
    _navigating = true;
    pushCount++;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Stage16Detail()),
    );
    _navigating = false;
  }

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN C: SingleChildScrollView — hapus wrapper ini untuk reproduksi
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 16 - Debugging')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(studentName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(studentId),
            const SizedBox(height: 12),
            const Text('Kasus A: teks panjang dalam Row'),
            Row(
              children: [
                const Icon(Icons.info),
                const SizedBox(width: 8),
                // PERBAIKAN A: Expanded — hapus untuk reproduksi
                Expanded(
                  child: Text(
                      '$studentId - $studentName - teks yang sangat panjang untuk menguji layout dalam Row'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Kasus B: ListView dalam Column'),
            SizedBox(
              height: 220,
              child: Column(
                children: [
                  const Text('Header daftar'),
                  // PERBAIKAN B: Expanded — hapus untuk reproduksi
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, i) =>
                          ListTile(title: Text('Item $i')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('Kasus C: form + keyboard'),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Ketuk di sini sampai keyboard muncul',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Kasus D: cegah push ganda'),
            ElevatedButton(
              onPressed: _openDetail,
              child: Text('Buka Detail (dibuka $pushCount x)'),
            ),
          ],
        ),
      ),
    );
  }
}

class Stage16Detail extends StatelessWidget {
  const Stage16Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail 16')),
      body: const Center(
        child: Text('Tanpa penjaga, spam-tap menumpuk halaman ini.'),
      ),
    );
  }
}