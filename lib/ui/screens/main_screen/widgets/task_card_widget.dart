import 'package:flutter/material.dart';
import '../../../../models/task_model.dart';
import '../../../../app_design/app_colors.dart';
import '../../../../app_design/app_indents.dart';
import '../../../../app_design/adaptive_sizes.dart';
import 'task_image_widget.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;
  final void Function(TaskModel) onTap;
  const TaskCardWidget({required this.task, required this.onTap, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(task),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: AdaptiveSizes.getAdaptiveHeight(context, AppIndents.small),
          horizontal: AdaptiveSizes.getAdaptiveWidth(
            context,
            AppIndents.medium,
          ),
        ),
        color: AppColors.darkGray,
        child: Padding(
          padding: EdgeInsets.all(
            AdaptiveSizes.getAdaptiveWidth(context, AppIndents.medium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskImageWidget(imageURL: task.imageURL),
              SizedBox(
                height: AdaptiveSizes.getAdaptiveHeight(
                  context,
                  AppIndents.small,
                ),
              ),
              Text(
                task.name,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                task.description,
                style: const TextStyle(color: AppColors.text, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
