import 'package:flutter/material.dart';
import '../../../models/priority.dart';
import '../../../app_design/app_indents.dart';
import '../../../app_design/adaptive_sizes.dart';
import 'widgets/create_task_header.dart';
import 'widgets/create_task_fields.dart';

class CreateTaskWidget extends StatefulWidget {
  final void Function(Map<String, dynamic>) onCreate;
  const CreateTaskWidget({required this.onCreate, Key? key}) : super(key: key);

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? description;
  TasksPriority? priority;
  int? scheduledHours;
  int? spentHours;
  String? imageURL;

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
            CreateTaskHeader(
              onAdd: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onCreate({
                    'name': name,
                    'description': description,
                    'priority': priority,
                    'scheduledHours': scheduledHours,
                    'spentHours': spentHours,
                    'imageURL': imageURL,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields except imageURL.'),
                    ),
                  );
                }
              },
            ),
            CreateTaskFields(
              onNameSaved: (value) => name = value,
              onDescriptionSaved: (value) => description = value,
              onPriorityChanged: (value) => priority = value,
              onScheduledHoursSaved: (value) =>
                  scheduledHours = int.tryParse(value ?? ''),
              onSpentHoursSaved: (value) =>
                  spentHours = int.tryParse(value ?? ''),
              onImageURLSaved: (value) => imageURL = value,
            ),
          ],
        ),
      ),
    );
  }
}
