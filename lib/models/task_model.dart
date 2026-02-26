import 'priority.dart';

class TaskModel {
  final int id;
  final String name;
  final String description;
  final TasksPriority priority;
  final int scheduledHours;
  final int spentHours;
  final String? imageURL;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.priority,
    required this.scheduledHours,
    required this.spentHours,
    this.imageURL,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      priority: TasksPriority.values[json['priority']],
      scheduledHours: json['scheduledHours'],
      spentHours: json['spentHours'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priority': priority.index,
      'scheduledHours': scheduledHours,
      'spentHours': spentHours,
      'imageURL': imageURL,
    };
  }
}
