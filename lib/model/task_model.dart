import 'package:flutter_todo/common/tasks_lists.dart';

class TaskModel {
  String id;
  String? title;
  String? category;
  String? date;
  String? time;
  bool isDone;

  TaskModel(
      {required this.id,
      required String this.title,
      required String this.category,
      required String this.date,
      this.time,
      this.isDone = false}) {
    if (isDone) {
      TasksList.instance.doneTasks.add(this);
    } else {
      TasksList.instance.dueTasks.add(this);
    }
  }

  void changeStatus() {
    isDone = !isDone;
    if (isDone) {
      TasksList.instance.doneTasks.add(this);
      TasksList.instance.dueTasks.removeWhere((element) => element.id == id);
    } else {
      TasksList.instance.doneTasks.removeWhere((element) => element.id == id);
      TasksList.instance.dueTasks.add(this);
    }
  }
}
