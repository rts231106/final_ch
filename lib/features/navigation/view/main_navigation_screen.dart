import 'package:final_ch/constatns/sizes.dart';
import 'package:final_ch/features/navigation/view/MoodTrackerScreen.dart';
import 'package:final_ch/features/navigation/view/post_screen.dart';
import 'package:final_ch/features/navigation/widget/nav_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends StatefulWidget {
  static String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "writing",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department_sharp,
              color: Colors.red,
            ),
            Text("MOOD"),
            Icon(
              Icons.local_fire_department_sharp,
              color: Colors.red,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const MoodTrackerScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const PostScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size96,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              isSelected: _selectedIndex == 0,
              icon: Icons.home_filled,
              selectedIcon: Icons.home_filled,
              onTap: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              isSelected: _selectedIndex == 1,
              icon: Icons.note_add_outlined,
              selectedIcon: Icons.note_add_rounded,
              onTap: () => _onTap(1),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
