import 'package:flutter/material.dart';

class CreateTaskHeader extends StatelessWidget {
  final VoidCallback onAdd;
  const CreateTaskHeader({required this.onAdd, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [IconButton(icon: const Icon(Icons.add), onPressed: onAdd)],
    );
  }
}
