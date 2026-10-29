import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_constants.dart';
import '../providers/course_provider.dart';
import 'course_form_screen.dart';
import 'courses_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class ExplorerShell extends StatefulWidget {
  const ExplorerShell({super.key});

  @override
  State<ExplorerShell> createState() => _ExplorerShellState();
}

class _ExplorerShellState extends State<ExplorerShell> {
  static const List<String> _titles = [
    'Course Explorer v2',
    'Courses',
    'Favorites',
    'Profile',
  ];

  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    HomeScreen(
      onOpenCourses: () => _select(1),
      onOpenFavorites: () => _select(2),
    ),
    CoursesScreen(onCreate: _openCreateCourse),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void _select(int index) {
    setState(() => _selectedIndex = index);
  }

  void _openCreateCourse() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CourseFormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCount = context.watch<CourseProvider>().favoriteCount;
    final isCompact = MediaQuery.sizeOf(context).width < 840;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_titles[_selectedIndex]),
            const Text(
              '$studentName • $studentId',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: isCompact
          ? IndexedStack(index: _selectedIndex, children: _pages)
          : Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _select,
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: _favoriteIcon(
                        favoriteCount,
                        Icons.favorite_border,
                      ),
                      selectedIcon: _favoriteIcon(
                        favoriteCount,
                        Icons.favorite,
                      ),
                      label: const Text('Favorites'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton.extended(
              onPressed: _openCreateCourse,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Course'),
            )
          : null,
      bottomNavigationBar: isCompact
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _select,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: _favoriteIcon(
                    favoriteCount,
                    Icons.favorite_border,
                  ),
                  selectedIcon: _favoriteIcon(
                    favoriteCount,
                    Icons.favorite,
                  ),
                  label: 'Favorites',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            )
          : null,
    );
  }

  Widget _favoriteIcon(int count, IconData icon) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      child: Icon(icon),
    );
  }
}