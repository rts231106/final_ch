import 'package:final_ch/constatns/sizes.dart';
import 'package:flutter/material.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Icon(
        isSelected ? selectedIcon : icon,
        color: isSelected ? Colors.white : Colors.grey.shade600,
        size: Sizes.size24,
      ),
    );
  }
}
