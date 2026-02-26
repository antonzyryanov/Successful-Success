import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/task_model.dart';
import '../../../../bloc/todo_bloc.dart';
import '../../../../bloc/todo_event.dart';
import '../../task_creation_screen/create_task_widget.dart';
import 'task_list_widget.dart';

class MainTabsWidget extends StatelessWidget {
  final dynamic state;
  final void Function(BuildContext, TaskModel, void Function(TaskModel))
  showTaskEditor;
  final int selectedIndex;
  const MainTabsWidget({
    required this.state,
    required this.showTaskEditor,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      CreateTaskWidget(
        onCreate: (taskData) async {
          final logger = context.read<ToDoBloc>().logger;
          logger.log('CreateTaskWidget: Creating task with data $taskData');
          final prefs = await SharedPreferences.getInstance();
          int lastId = prefs.getInt('lastTaskIndex') ?? 0;
          final newId = lastId + 1;
          await prefs.setInt('lastTaskIndex', newId);
          final task = TaskModel(
            id: newId,
            name: taskData['name'],
            description: taskData['description'],
            priority: taskData['priority'],
            scheduledHours: taskData['scheduledHours'],
            spentHours: taskData['spentHours'],
            imageURL: taskData['imageURL'],
          );
          context.read<ToDoBloc>().add(UpdateTasksGroup(task));
        },
      ),
      TaskListWidget(
        tasks: state.highPriorityTasksModel.tasks,
        sectionName: state.highPriorityTasksModel.name,
        onTap: (task) => showTaskEditor(context, task, (updatedTask) {
          final logger = context.read<ToDoBloc>().logger;
          logger.log('TaskListWidget: Editing task id=${updatedTask.id}');
          context.read<ToDoBloc>().add(UpdateTasksGroup(updatedTask));
        }),
      ),
      TaskListWidget(
        tasks: state.midPriorityTasksModel.tasks,
        sectionName: state.midPriorityTasksModel.name,
        onTap: (task) => showTaskEditor(context, task, (updatedTask) {
          context.read<ToDoBloc>().add(UpdateTasksGroup(updatedTask));
        }),
      ),
      TaskListWidget(
        tasks: state.lowPriorityTasksModel.tasks,
        sectionName: state.lowPriorityTasksModel.name,
        onTap: (task) => showTaskEditor(context, task, (updatedTask) {
          context.read<ToDoBloc>().add(UpdateTasksGroup(updatedTask));
        }),
      ),
      TaskListWidget(
        tasks: state.archivedTasksModel.tasks,
        sectionName: state.archivedTasksModel.name,
        onTap: (task) => showTaskEditor(context, task, (updatedTask) {
          context.read<ToDoBloc>().add(UpdateTasksGroup(updatedTask));
        }),
      ),
    ];
    return IndexedStack(index: selectedIndex, children: tabs);
  }
}
