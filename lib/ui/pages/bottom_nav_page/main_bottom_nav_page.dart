import 'package:flutter/material.dart';
import 'package:task_manager/ui/pages/bottom_nav_page/new_task_list_page.dart';
import 'package:task_manager/ui/pages/bottom_nav_page/progress_task_list_page.dart';

class MainBottomNavPage extends StatefulWidget {
  const MainBottomNavPage({super.key});

  static const String name = '/main-bottom-nav-page';

  @override
  State<MainBottomNavPage> createState() => _MainBottomNavPageState();
}

class _MainBottomNavPageState extends State<MainBottomNavPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    NewTaskListPage(),
    ProgressTaskListPage(),
    NewTaskListPage(),
    NewTaskListPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index){
          _selectedIndex = index;
          setState(() {

          });
        },
          destinations: [
            NavigationDestination(icon: Icon(Icons.add_task), label: "New"),
            NavigationDestination(icon: Icon(Icons.pending_actions), label: "Progress"),
            NavigationDestination(icon: Icon(Icons.task_alt), label: "Completed"),
            NavigationDestination(icon: Icon(Icons.cancel_outlined), label: "Cancelled"),
          ]
      ),
    );
  }
}
