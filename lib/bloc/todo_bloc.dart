import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:successful_success/models/priority.dart';
import '../models/tasks_group.dart';
import '../repository/todo_data_repository.dart';
import '../services/app_logger_service.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoDataRepository repository;
  final AppLoggerService logger;

  TasksGroup highPriorityTasksModel;
  TasksGroup midPriorityTasksModel;
  TasksGroup lowPriorityTasksModel;
  TasksGroup archivedTasksModel;

  ToDoBloc({required this.repository, required this.logger})
    : highPriorityTasksModel = TasksGroup(
        priority: TasksPriority.High,
        name: 'High Priority',
        tasks: [],
      ),
      midPriorityTasksModel = TasksGroup(
        priority: TasksPriority.Medium,
        name: 'Medium Priority',
        tasks: [],
      ),
      lowPriorityTasksModel = TasksGroup(
        priority: TasksPriority.Low,
        name: 'Low Priority',
        tasks: [],
      ),
      archivedTasksModel = TasksGroup(
        priority: TasksPriority.Archived,
        name: 'Archived',
        tasks: [],
      ),
      super(ToDoLoading()) {
    logger.log('ToDoBloc initialized');
    on<FetchAllTasksGroups>((event, emit) async {
      logger.log('Event: FetchAllTasksGroups');
      emit(ToDoLoading());
      try {
        await repository.fetchTaskGroup(0, (group) {
          logger.log('Loaded high priority group');
          highPriorityTasksModel = group;
        });
        await repository.fetchTaskGroup(1, (group) {
          logger.log('Loaded mid priority group');
          midPriorityTasksModel = group;
        });
        await repository.fetchTaskGroup(2, (group) {
          logger.log('Loaded low priority group');
          lowPriorityTasksModel = group;
        });
        await repository.fetchTaskGroup(3, (group) {
          logger.log('Loaded archived group');
          archivedTasksModel = group;
        });
        emit(
          ToDoLoaded(
            highPriorityTasksModel: highPriorityTasksModel,
            midPriorityTasksModel: midPriorityTasksModel,
            lowPriorityTasksModel: lowPriorityTasksModel,
            archivedTasksModel: archivedTasksModel,
          ),
        );
        logger.log('Tasks groups loaded');
      } catch (e) {
        logger.log('Error loading tasks groups: $e');
        emit(ToDoError(e.toString()));
      }
    });
    on<UpdateTasksGroup>((event, emit) async {
      logger.log('Event: UpdateTasksGroup for task id=${event.task.id}');
      emit(ToDoLoading());
      try {
        final task = event.task;
        TasksGroup? oldGroup;
        if (highPriorityTasksModel.tasks.any((t) => t.id == task.id)) {
          oldGroup = highPriorityTasksModel;
        } else if (midPriorityTasksModel.tasks.any((t) => t.id == task.id)) {
          oldGroup = midPriorityTasksModel;
        } else if (lowPriorityTasksModel.tasks.any((t) => t.id == task.id)) {
          oldGroup = lowPriorityTasksModel;
        } else if (archivedTasksModel.tasks.any((t) => t.id == task.id)) {
          oldGroup = archivedTasksModel;
        }

        if (oldGroup != null && oldGroup.priority != task.priority) {
          oldGroup.tasks.removeWhere((t) => t.id == task.id);
          await repository.saveTaskGroup(oldGroup);
        }

        TasksGroup group;
        switch (task.priority) {
          case TasksPriority.High:
            group = highPriorityTasksModel;
            break;
          case TasksPriority.Medium:
            group = midPriorityTasksModel;
            break;
          case TasksPriority.Low:
            group = lowPriorityTasksModel;
            break;
          case TasksPriority.Archived:
            group = archivedTasksModel;
            break;
        }
        final idx = group.tasks.indexWhere((t) => t.id == task.id);
        if (idx >= 0) {
          logger.log('Updating existing task with id=${task.id}');
          group.tasks[idx] = task;
        } else {
          logger.log('Adding new task with id=${task.id}');
          group.tasks.add(task);
        }

        await repository.saveTaskGroup(group);
        logger.log('Saved updated group for priority ${task.priority.index}');

        switch (task.priority) {
          case TasksPriority.High:
            highPriorityTasksModel = group;
            break;
          case TasksPriority.Medium:
            midPriorityTasksModel = group;
            break;
          case TasksPriority.Low:
            lowPriorityTasksModel = group;
            break;
          case TasksPriority.Archived:
            archivedTasksModel = group;
            break;
        }
        emit(
          ToDoLoaded(
            highPriorityTasksModel: highPriorityTasksModel,
            midPriorityTasksModel: midPriorityTasksModel,
            lowPriorityTasksModel: lowPriorityTasksModel,
            archivedTasksModel: archivedTasksModel,
          ),
        );
        logger.log('Task updated: ${task.name}');
      } catch (e) {
        logger.log('Error updating task: $e');
        emit(ToDoError(e.toString()));
      }
    });
  }
}
