import 'package:flutter/material.dart';
import '../../../../app_design/app_indents.dart';
import '../../../../app_design/adaptive_sizes.dart';

class TaskEditorHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onUpdate;
  const TaskEditorHeader({
    required this.onBack,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AdaptiveSizes.getAdaptiveWidth(context, AppIndents.small),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: AdaptiveSizes.getAdaptiveWidth(context, AppIndents.small),
          ),
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onUpdate,
          ),
        ),
      ],
    );
  }
}
