import 'package:successful_success/models/priority.dart';
import 'package:successful_success/models/task_model.dart';
import '../models/tasks_group.dart';
import '../services/app_logger_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class ToDoDataRepository {
  Future<void> fetchTaskGroup(int priority, void Function(TasksGroup) callback);
  Future<void> saveTaskGroup(TasksGroup group);
}

class LocalToDoDataRepository extends ToDoDataRepository {
  final AppLoggerService logger;
  LocalToDoDataRepository({required this.logger});
  @override
  Future<void> fetchTaskGroup(
    int priority,
    void Function(TasksGroup) callback,
  ) async {
    try {
      logger.log('Fetching group for priority $priority');
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/assets/data/$priority/group.json');
      if (await file.exists()) {
        final String jsonString = await file.readAsString();
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final group = TasksGroup.fromJson(jsonMap);
        logger.log(
          'Fetched group: ${group.name} with ${group.tasks.length} tasks',
        );
        callback(group);
      } else {
        logger.log('Group file not found, returning empty group');
        callback(
          TasksGroup(
            priority: TasksPriority.values[priority],
            name: '',
            tasks: <TaskModel>[],
          ),
        );
      }
    } catch (e) {
      logger.log('Error fetching group for priority $priority: $e');
      callback(
        TasksGroup(
          priority: TasksPriority.values[priority],
          name: '',
          tasks: <TaskModel>[],
        ),
      );
    }
  }

  @override
  Future<void> saveTaskGroup(TasksGroup group) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/assets/data/${group.priority.index}/group.json',
      );
      await file.create(recursive: true);
      await file.writeAsString(json.encode(group.toJson()));
      logger.log('Saved group ${group.name} with ${group.tasks.length} tasks');
    } catch (e) {
      logger.log('Error saving group: $e');
    }
  }
}
