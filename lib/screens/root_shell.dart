import 'package:flutter/material.dart';
import 'package:right_now/screens/profile_screen.dart';
import 'package:right_now/utils/constants.dart';

import 'ai_screen.dart';
import 'cases_screen.dart';
import 'discover_screen.dart';
import 'home_screen.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CasesScreen(),
    DiscoverScreen(),
    AIScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              width: 0.5,
            ),
          ),
          boxShadow: [
            if (isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.colorScheme.surface,
          selectedItemColor: kPrimaryBlue,
          unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey[600],
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: kPrimaryBlue,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: _selectedIndex == 0
                    ? kPrimaryBlue
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              activeIcon: const Icon(Icons.home, color: kPrimaryBlue),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.gavel,
                color: _selectedIndex == 1
                    ? kPrimaryBlue
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              activeIcon: const Icon(Icons.gavel, color: kPrimaryBlue),
              label: 'Cases',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _selectedIndex == 2
                    ? kPrimaryBlue
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              activeIcon: const Icon(Icons.search, color: kPrimaryBlue),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.smart_toy_outlined,
                color: _selectedIndex == 3
                    ? kPrimaryBlue
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              activeIcon: const Icon(Icons.smart_toy, color: kPrimaryBlue),
              label: 'AI',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: _selectedIndex == 4
                    ? kPrimaryBlue
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
              activeIcon: const Icon(Icons.person, color: kPrimaryBlue),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}