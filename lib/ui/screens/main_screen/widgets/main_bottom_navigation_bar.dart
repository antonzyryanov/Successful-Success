import 'package:flutter/material.dart';
import '../../../../app_design/app_colors.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTabTapped;
  const MainBottomNavigationBar({
    required this.selectedIndex,
    required this.onTabTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.tabBar,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.gray,
      currentIndex: selectedIndex,
      onTap: onTabTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'High'),
        BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Medium'),
        BottomNavigationBarItem(icon: Icon(Icons.trending_down), label: 'Low'),
        BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
      ],
    );
  }
}
