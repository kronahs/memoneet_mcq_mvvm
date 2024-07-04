import 'package:daily_mcq_mvvm/view/home_screen/home_screen.dart';
import 'package:daily_mcq_mvvm/view/streak_screen/streak_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int? selectedTabIndex;

  BottomNavigation({super.key,  this.selectedTabIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTabIndex,
        children: [
          HomePage(),
          StreakScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        // backgroundColor:
        onDestinationSelected: (int index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        selectedIndex: _selectedTabIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon:  Icon(Icons.fireplace),
            icon: Icon(Icons.fireplace_outlined),
            label: 'Streaks',
          ),
        ],
      ),
    );
  }
}
