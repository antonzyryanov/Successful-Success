import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../models/priority.dart';
import '../../../app_design/app_indents.dart';
import '../../../app_design/adaptive_sizes.dart';
import 'widgets/task_editor_header.dart';
import 'widgets/task_editor_fields.dart';

class TaskEditorWidget extends StatefulWidget {
  final TaskModel task;
  final void Function(TaskModel) onUpdate;
  const TaskEditorWidget({required this.task, required this.onUpdate, Key? key})
    : super(key: key);

  @override
  State<TaskEditorWidget> createState() => _TaskEditorWidgetState();
}

class _TaskEditorWidgetState extends State<TaskEditorWidget> {
  late String name;
  late String description;
  late TasksPriority priority;
  late int scheduledHours;
  late int spentHours;
  String? imageURL;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    name = widget.task.name;
    description = widget.task.description;
    priority = widget.task.priority;
    scheduledHours = widget.task.scheduledHours;
    spentHours = widget.task.spentHours;
    imageURL = widget.task.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(
          AdaptiveSizes.getAdaptiveWidth(context, AppIndents.medium),
        ),
        child: Column(
          children: [
            TaskEditorHeader(
              onBack: () => Navigator.of(context).maybePop(),
              onUpdate: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onUpdate(
                    TaskModel(
                      id: widget.task.id,
                      name: name,
                      description: description,
                      priority: priority,
                      scheduledHours: scheduledHours,
                      spentHours: spentHours,
                      imageURL: imageURL,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields except imageURL.'),
                    ),
                  );
                }
              },
            ),
            TaskEditorFields(
              name: name,
              description: description,
              priority: priority,
              scheduledHours: scheduledHours,
              spentHours: spentHours,
              imageURL: imageURL,
              onNameSaved: (value) => name = value ?? '',
              onDescriptionSaved: (value) => description = value ?? '',
              onPriorityChanged: (value) => priority = value ?? priority,
              onScheduledHoursSaved: (value) =>
                  scheduledHours = int.tryParse(value ?? '') ?? scheduledHours,
              onSpentHoursSaved: (value) =>
                  spentHours = int.tryParse(value ?? '') ?? spentHours,
              onImageURLSaved: (value) => imageURL = value,
            ),
          ],
        ),
      ),
    );
  }
}
