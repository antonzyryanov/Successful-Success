import 'package:flutter/material.dart';
import '../../../../models/priority.dart';

class CreateTaskFields extends StatelessWidget {
  final void Function(String?) onNameSaved;
  final void Function(String?) onDescriptionSaved;
  final void Function(TasksPriority?) onPriorityChanged;
  final void Function(String?) onScheduledHoursSaved;
  final void Function(String?) onSpentHoursSaved;
  final void Function(String?) onImageURLSaved;

  const CreateTaskFields({
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
          decoration: const InputDecoration(labelText: 'Name'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onNameSaved,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Description'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onDescriptionSaved,
        ),
        DropdownButtonFormField<TasksPriority>(
          decoration: const InputDecoration(labelText: 'Priority'),
          items: TasksPriority.values
              .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
              .toList(),
          validator: (value) => value == null ? 'Required' : null,
          onChanged: onPriorityChanged,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Scheduled Hours'),
          keyboardType: TextInputType.number,
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onScheduledHoursSaved,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Spent Hours'),
          keyboardType: TextInputType.number,
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          onSaved: onSpentHoursSaved,
        ),
        TextFormField(
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
