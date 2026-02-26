import '../models/tasks_group.dart';

abstract class ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final TasksGroup highPriorityTasksModel;
  final TasksGroup midPriorityTasksModel;
  final TasksGroup lowPriorityTasksModel;
  final TasksGroup archivedTasksModel;
  ToDoLoaded({
    required this.highPriorityTasksModel,
    required this.midPriorityTasksModel,
    required this.lowPriorityTasksModel,
    required this.archivedTasksModel,
  });
}

class ToDoError extends ToDoState {
  final String message;
  ToDoError(this.message);
}
