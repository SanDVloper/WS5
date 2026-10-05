import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

final List<Map<String, dynamic>> courses = [
  {
    'code': 'MOB01',
    'title': 'Git & GitHub',
    'credits': 2,
    'status': 'done',
    'desc': 'Version control untuk kolaborasi kode.'
  },
  {
    'code': 'MOB02',
    'title': 'Dart Fundamentals',
    'credits': 2,
    'status': 'done',
    'desc': 'Dasar bahasa Dart untuk Flutter.'
  },
  {
    'code': 'MOB03',
    'title': 'Flutter UI Fundamentals',
    'credits': 3,
    'status': 'active',
    'desc': 'Widget, layout, dan list statik.'
  },
  {
    'code': 'MOB04',
    'title': 'Navigation',
    'credits': 2,
    'status': 'planned',
    'desc': 'Navigasi multi-screen dan passing data.'
  },
  {
    'code': 'MOB05',
    'title': 'State Management',
    'credits': 3,
    'status': 'planned',
    'desc': 'Pengelolaan state aplikasi.'
  },
];

// Shell adaptif: NavigationBar (<840) vs NavigationRail (>=840)
class ExplorerShell extends StatefulWidget {
  const ExplorerShell({super.key});

  @override
  State<ExplorerShell> createState() => _ExplorerShellState();
}

class _ExplorerShellState extends State<ExplorerShell> {
  int selectedIndex = 0;

  static const List<Widget> pages = [
    ExplorerHome(),
    CoursesPage(),
    ProfilePage(),
  ];

  static const List<String> titles = [
    'Course Explorer',
    'Courses',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          return Scaffold(
            appBar: AppBar(title: Text(titles[selectedIndex])),
            body: pages[selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (i) =>
                  setState(() => selectedIndex = i),
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.school), label: 'Courses'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(titles[selectedIndex])),
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (i) =>
                    setState(() => selectedIndex = i),
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home')),
                  NavigationRailDestination(
                      icon: Icon(Icons.school),
                      label: Text('Courses')),
                  NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile')),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: pages[selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

class ExplorerHome extends StatelessWidget {
  const ExplorerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final total = courses.length;
    final done =
        courses.where((c) => c['status'] == 'done').length;
    final sks = courses.fold<int>(
        0, (sum, c) => sum + (c['credits'] as int));
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  CircleAvatar(
                      radius: 36,
                      child: Icon(Icons.person, size: 36)),
                  SizedBox(height: 8),
                  Text(studentName,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(studentId),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('$total\nTopik',
                              textAlign: TextAlign.center)))),
              Expanded(
                  child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('$sks\nTotal SKS',
                              textAlign: TextAlign.center)))),
              Expanded(
                  child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('$done\nSelesai',
                              textAlign: TextAlign.center)))),
            ],
          ),
          const SizedBox(height: 8),
          Text('$done dari $total topik selesai'),
        ],
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = columnsFor(constraints.maxWidth);
        if (cols == 1) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: courses.length,
            itemBuilder: (context, index) =>
                _buildItem(context, courses[index]),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) =>
              _buildItem(context, courses[index]),
        );
      },
    );
  }

  Widget _buildItem(
      BuildContext context, Map<String, dynamic> course) {
    return CourseCard(
      course: course,
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        final fav = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailPage(course: course),
          ),
        );
        if (fav == true) {
          messenger.showSnackBar(
            SnackBar(
                content: Text(
                    '${course['title']} ditandai favorit')),
          );
        }
      },
    );
  }
}

// Reusable 1: kartu course
class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback onTap;

  const CourseCard(
      {super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDone = course['status'] == 'done';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDone
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: isDone ? Colors.green : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                course['title'] as String,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '${course['code']} • ${course['credits']} SKS'),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() =>
      _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    return Scaffold(
      appBar: AppBar(title: Text(course['title'] as String)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['title'] as String,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Kode: ${course['code']}'),
            Text('SKS: ${course['credits']}'),
            Text('Status: ${course['status']}'),
            const SizedBox(height: 8),
            Text(course['desc'] as String),
            const Divider(height: 24),
            Text('$studentId - $studentName',
                style:
                    const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  tooltip: 'Favorite',
                  onPressed: () =>
                      setState(() => isFavorite = !isFavorite),
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(context, true),
                    child:
                        const Text('Tandai Favorit & Kembali'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          CircleAvatar(
              radius: 36, child: Icon(Icons.person, size: 36)),
          SizedBox(height: 8),
          Text(studentName,
              style:
                  TextStyle(fontWeight: FontWeight.bold)),
          Text(studentId),
          SizedBox(height: 16),
          FeedbackForm(),
        ],
      ),
    );
  }
}

// Reusable 2: form feedback dengan validasi
class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final formKey = GlobalKey<FormState>();
  final nameController =
      TextEditingController(text: studentName);
  final nimController = TextEditingController(text: studentId);
  final commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Feedback berhasil dikirim')),
      );
      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Form Feedback',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty)
                    ? 'Nama wajib diisi'
                    : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: nimController,
            decoration: const InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty)
                    ? 'NIM wajib diisi'
                    : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Komentar (min. 5 karakter)',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().length < 5)
                    ? 'Komentar minimal 5 karakter'
                    : null,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}