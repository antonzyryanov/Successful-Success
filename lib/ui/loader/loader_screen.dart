import 'package:flutter/material.dart';
import 'package:successful_success/ui/loader/loader_widget.dart';
import '../../app_design/app_colors.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const LoaderWidget(),
    );
  }
}
