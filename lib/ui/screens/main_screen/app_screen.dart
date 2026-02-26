import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:successful_success/bloc/todo_state.dart';
import '../../../bloc/todo_bloc.dart';
import '../../../models/task_model.dart';
import '../../../app_design/app_durations.dart';
import '../splash_screen/splash_screen.dart';
import '../../loader/loader_screen.dart';
import '../error_screen/error_screen.dart';
import '../main_screen/widgets/task_editor_with_loader.dart';
import '../main_screen/main_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: AppDurations.splashDurationMs),
      () => setState(() => _showSplash = false),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showTaskEditor(
    BuildContext context,
    TaskModel task,
    void Function(TaskModel) onUpdate,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return BlocProvider.value(
          value: BlocProvider.of<ToDoBloc>(context),
          child: TaskEditorWithLoader(task: task, onUpdate: onUpdate),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashScreen();
    }
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        if (state is ToDoLoading) {
          return const LoaderScreen();
        } else if (state is ToDoError) {
          return ErrorScreen(message: state.message);
        } else if (state is ToDoLoaded) {
          return MainScreen(
            state: state,
            showTaskEditor: _showTaskEditor,
            selectedIndex: _selectedIndex,
            onTabTapped: _onTabTapped,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
