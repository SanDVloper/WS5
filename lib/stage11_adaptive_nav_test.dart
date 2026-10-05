import 'package:flutter/material.dart';

const String studentName = 'I Kadek Santa Buana Gotama';
const String studentId = '2415051019';

class Stage11AdaptiveNav extends StatefulWidget {
  const Stage11AdaptiveNav({super.key});

  @override
  State<Stage11AdaptiveNav> createState() =>
      _Stage11AdaptiveNavState();
}

class _Stage11AdaptiveNavState extends State<Stage11AdaptiveNav> {
  int selectedIndex = 0;

  Widget get currentPage {
    switch (selectedIndex) {
      case 0:
        return const Stage11Home();
      case 1:
        return const Stage11Courses();
      default:
        return const Stage11Profile();
    }
  }

  NavigationBar buildNavBar() {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() => selectedIndex = index);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.school), label: 'Courses'),
        NavigationDestination(
            icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  NavigationRail buildNavRail() {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() => selectedIndex = index);
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
            icon: Icon(Icons.home), label: Text('Home')),
        NavigationRailDestination(
            icon: Icon(Icons.school), label: Text('Courses')),
        NavigationRailDestination(
            icon: Icon(Icons.person), label: Text('Profile')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          return Scaffold(
            body: currentPage,
            bottomNavigationBar: buildNavBar(),
          );
        }
        return Scaffold(
          body: Row(
            children: [
              buildNavRail(),
              const VerticalDivider(width: 1),
              Expanded(child: currentPage),
            ],
          ),
        );
      },
    );
  }
}

class Stage11Home extends StatelessWidget {
  const Stage11Home({super.key});

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

class Stage11Courses extends StatelessWidget {
  const Stage11Courses({super.key});

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

class Stage11Profile extends StatelessWidget {
  const Stage11Profile({super.key});

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