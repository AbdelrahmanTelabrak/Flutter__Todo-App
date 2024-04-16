import '../model/task_model.dart';

class TasksList {

  TasksList._privateConstructor();

  static final TasksList instance = TasksList._privateConstructor();

  List<TaskModel> dueTasks = [];
  List<TaskModel> doneTasks = [];

}