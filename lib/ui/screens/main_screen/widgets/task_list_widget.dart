import 'package:flutter/material.dart';
import '../../../../models/task_model.dart';
import '../../../../app_design/app_colors.dart';
import '../../../../app_design/app_indents.dart';
import '../../../../app_design/adaptive_sizes.dart';
import 'task_card_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final void Function(TaskModel) onTap;
  final String sectionName;
  const TaskListWidget({
    required this.tasks,
    required this.onTap,
    required this.sectionName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(
            AdaptiveSizes.getAdaptiveWidth(context, AppIndents.medium),
          ),
          child: Text(
            sectionName,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCardWidget(task: task, onTap: onTap);
            },
          ),
        ),
      ],
    );
  }
}
