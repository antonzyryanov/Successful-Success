import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:successful_success/app_design/app_colors.dart';
import 'package:successful_success/bloc/todo_bloc.dart';
import 'package:successful_success/bloc/todo_event.dart';
import 'package:successful_success/services/app_logger_service.dart';
import 'package:successful_success/repository/todo_data_repository.dart';
import 'ui/screens/app_screen/app_screen.dart';

void main() {
  runApp(SuccessfulSuccessApp());
}

class SuccessfulSuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final logger = AppLoggerService();
        final bloc = ToDoBloc(
          repository: LocalToDoDataRepository(logger: logger),
          logger: logger,
        );
        logger.log('App started, dispatching FetchAllTasksGroups');
        bloc.add(FetchAllTasksGroups());
        return bloc;
      },
      child: MaterialApp(
        title: 'Successful Success',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
          useMaterial3: true,
        ),
        home: AppScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
