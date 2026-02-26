import 'package:flutter/material.dart';
import '../../../../app_design/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Error: $message')),
    );
  }
}
