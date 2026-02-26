import 'package:flutter/material.dart';
import '../../../../models/priority.dart';

class TaskEditorFields extends StatelessWidget {
  final String name;
  final String description;
  final TasksPriority priority;
  final int scheduledHours;
  final int spentHours;
  final String? imageURL;
  final void Function(String?)? onNameSaved;
  final void Function(String?)? onDescriptionSaved;
  final void Function(TasksPriority?)? onPriorityChanged;
  final void Function(String?)? onScheduledHoursSaved;
  final void Function(String?)? onSpentHoursSaved;
  final void Function(String?)? onImageURLSaved;

  const TaskEditorFields({
    required this.name,
    required this.description,
    required this.priority,
    required this.scheduledHours,
    required this.spentHours,
    required this.imageURL,
    required this.onNameSaved,
    required this.onDescriptionSaved,
    required this.onPriorityChanged,
    required this.onScheduledHoursSaved,
    required this.onSpentHoursSaved,
    required this.onImageURLSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: name,
          decoration: const InputDecoration(labelText: 'Name'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onNameSaved,
        ),
        TextFormField(
          initialValue: description,
          decoration: const InputDecoration(labelText: 'Description'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onDescriptionSaved,
        ),
        DropdownButtonFormField<TasksPriority>(
          value: priority,
          decoration: const InputDecoration(labelText: 'Priority'),
          items: TasksPriority.values
              .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
              .toList(),
          validator: (value) => value == null ? 'Required' : null,
          onChanged: onPriorityChanged,
        ),
        TextFormField(
          initialValue: scheduledHours.toString(),
          decoration: const InputDecoration(labelText: 'Scheduled Hours'),
          keyboardType: TextInputType.number,
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onScheduledHoursSaved,
        ),
        TextFormField(
          initialValue: spentHours.toString(),
          decoration: const InputDecoration(labelText: 'Spent Hours'),
          keyboardType: TextInputType.number,
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onSpentHoursSaved,
        ),
        TextFormField(
          initialValue: imageURL,
          decoration: const InputDecoration(
            labelText: 'Image URL',
            helperText: 'Optional',
          ),
          onSaved: onImageURLSaved,
        ),
      ],
    );
  }
}
