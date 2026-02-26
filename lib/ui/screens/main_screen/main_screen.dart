import 'package:flutter/material.dart';
import '../../../app_design/app_colors.dart';
import '../../../models/task_model.dart';
import 'widgets/main_tabs_widget.dart';
import 'widgets/main_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  final dynamic state;
  final void Function(BuildContext, TaskModel, void Function(TaskModel))
  showTaskEditor;
  final int selectedIndex;
  final void Function(int) onTabTapped;
  const MainScreen({
    required this.state,
    required this.showTaskEditor,
    required this.selectedIndex,
    required this.onTabTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: MainTabsWidget(
          state: state,
          showTaskEditor: showTaskEditor,
          selectedIndex: selectedIndex,
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(
        selectedIndex: selectedIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
