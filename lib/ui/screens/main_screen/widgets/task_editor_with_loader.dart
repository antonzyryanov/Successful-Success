import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:successful_success/bloc/todo_bloc.dart';
import 'package:successful_success/bloc/todo_state.dart';
import 'package:successful_success/models/task_model.dart';
import 'package:successful_success/ui/screens/task_editor_screen/task_editor_widget.dart';

class TaskEditorWithLoader extends StatefulWidget {
  final TaskModel task;
  final void Function(TaskModel) onUpdate;
  const TaskEditorWithLoader({required this.task, required this.onUpdate});

  @override
  State<TaskEditorWithLoader> createState() => TaskEditorWithLoaderState();
}

class TaskEditorWithLoaderState extends State<TaskEditorWithLoader> {
  bool _loading = false;
  late ToDoState _lastState;

  @override
  void initState() {
    super.initState();
    _lastState = context.read<ToDoBloc>().state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ToDoBloc, ToDoState>(
      listener: (context, state) {
        if (_loading && state is ToDoLoaded && state != _lastState) {
          Navigator.of(context).maybePop();
        }
        _lastState = state;
      },
      child: Stack(
        children: [
          Opacity(
            opacity: _loading ? 0.5 : 1.0,
            child: TaskEditorWidget(
              task: widget.task,
              onUpdate: (updatedTask) async {
                setState(() => _loading = true);
                widget.onUpdate(updatedTask);
              },
            ),
          ),
          if (_loading)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
