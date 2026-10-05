import 'dart:convert';
import 'stage2_mediaquery_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Tahap 12: baca JSON statik dari assets
Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString =
      await rootBundle.loadString('assets/data/student_data.json');
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

// Tahap 2: main() + runApp()
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const Stage2MediaQueryTest(),
    );
  }
}

// Tahap 13: StatefulWidget + late + initState (future dibuat 1x, bukan di build)
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  void _reload() {
    setState(() {
      studentFuture = loadStudentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Gagal memuat data: ${snapshot.error}'),
              ),
            );
          }

          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses =
              (data['courses'] as List).cast<Map<String, dynamic>>();

          // Tahap 11: ringkasan collection
          final total = courses.length;
          final doneCount =
              courses.where((c) => c['status'] == 'done').length;
          final totalCredits = courses.fold<int>(
              0, (sum, c) => sum + (c['credits'] as int));

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeader(student: student),
                const SizedBox(height: 8),
                // Tahap 6: Row berisi 3 reusable card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      StatCard(
                          value: '$total',
                          label: 'Topik',
                          icon: Icons.widgets),
                      StatCard(
                          value: '$totalCredits',
                          label: 'Total SKS',
                          icon: Icons.school),
                      StatCard(
                          value: '$doneCount',
                          label: 'Selesai',
                          icon: Icons.check_circle),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Tahap 9: input + setState
                const GreetingCard(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child:
                      Text('$doneCount dari $total topik selesai'),
                ),
                // Tahap 10: ListView dari collection
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseTile(course: courses[index]);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Tahap 5+7: kartu identitas + foto asset (otomatis ikon bila file tak ada)
class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> student;

  const ProfileHeader({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: 92,
                  height: 92,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 92,
                      height: 92,
                      color: Colors.indigo.shade100,
                      child: const Icon(Icons.person, size: 56),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                student['name'] as String,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(student['nim'] as String),
              const SizedBox(height: 8),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_android),
                  SizedBox(width: 8),
                  Text('Mobile Programming Student'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tahap 8: reusable widget dipakai 3x dengan data berbeda
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const StatCard(
      {super.key,
      required this.value,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

// Tahap 11: item list dengan status conditional
class CourseTile extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final status = course['status'] as String;
    final bool isDone = status == 'done';
    final bool isActive = status == 'active';
    final IconData icon = isDone
        ? Icons.check_circle
        : (isActive ? Icons.play_circle_fill : Icons.schedule);
    final Color color = isDone
        ? Colors.green
        : (isActive ? Colors.blue : Colors.grey);
    final String label =
        isDone ? 'Selesai' : (isActive ? 'Aktif' : 'Rencana');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(course['title'] as String),
        subtitle: Text(
            "${course['code']} • ${course['credits']} SKS • ${course['lecturer']}"),
        trailing: Text(label,
            style:
                TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// Tahap 9: StatefulWidget + TextField + setState + dispose
class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  final TextEditingController controller = TextEditingController();
  String message = 'Belum ada pesan';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Sapa',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Tulis pesan...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    message = controller.text.trim().isEmpty
                        ? 'Input masih kosong'
                        : controller.text.trim();
                  });
                },
                child: const Text('Tampilkan'),
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}