import 'task_model.dart';
import 'priority.dart';

class TasksGroup {
  final TasksPriority priority;
  final String name;
  final List<TaskModel> tasks;

  TasksGroup({required this.priority, required this.name, required this.tasks});

  factory TasksGroup.fromJson(Map<String, dynamic> json) {
    return TasksGroup(
      priority: TasksPriority.values[json['priority']],
      name: json['name'],
      tasks: (json['tasks'] as List)
          .map((task) => TaskModel.fromJson(task))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priority': priority.index,
      'name': name,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }
}
