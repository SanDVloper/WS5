import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage10NavBar extends StatefulWidget {
  const Stage10NavBar({super.key});

  @override
  State<Stage10NavBar> createState() => _Stage10NavBarState();
}

class _Stage10NavBarState extends State<Stage10NavBar> {
  int selectedIndex = 0;

  static const List<Widget> pages = [
    Stage10Home(),
    Stage10Courses(),
    Stage10Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 10 - NavigationBar')),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
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
}

class Stage10Home extends StatelessWidget {
  const Stage10Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(studentName,
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(studentId),
          SizedBox(height: 8),
          Text('Halaman Home'),
        ],
      ),
    );
  }
}

class Stage10Courses extends StatelessWidget {
  const Stage10Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('$studentId - $studentName',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Card(child: ListTile(title: Text('Git & GitHub'))),
        Card(child: ListTile(title: Text('Dart Fundamentals'))),
        Card(child: ListTile(title: Text('Flutter UI Fundamentals'))),
      ],
    );
  }
}

class Stage10Profile extends StatelessWidget {
  const Stage10Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
              radius: 40, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 8),
          Text(studentName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(studentId),
        ],
      ),
    );
  }
}