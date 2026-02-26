import 'package:flutter/material.dart';
import '../../../../app_design/adaptive_sizes.dart';

class TaskImageWidget extends StatelessWidget {
  final String? imageURL;
  const TaskImageWidget({required this.imageURL, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageURL != null && imageURL!.isNotEmpty) {
      return Center(
        child: Image.network(
          imageURL!,
          height: AdaptiveSizes.getAdaptiveHeight(context, 120),
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Center(
        child: Image.asset(
          'assets/images/placeholder/placeholder.png',
          height: AdaptiveSizes.getAdaptiveHeight(context, 120),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
