import 'package:successful_success/models/task_model.dart';

abstract class ToDoEvent {}

class FetchAllTasksGroups extends ToDoEvent {}

class UpdateTasksGroup extends ToDoEvent {
  final TaskModel task;
  UpdateTasksGroup(this.task);
}
