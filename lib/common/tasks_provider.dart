import 'package:flutter/material.dart';
import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/tasks_lists.dart';

import '../model/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> dueTasks = TasksList.instance.dueTasks;
  List<TaskModel> doneTasks = TasksList.instance.doneTasks;

  void updateTask(TaskModel task) {
    task.changeStatus();
    dueTasks = TasksList.instance.dueTasks;
    doneTasks = TasksList.instance.doneTasks;
    notifyListeners();
  }

  void addTask({
    required String title,
    required String category,
    String? date,
    String? time,
  }) {
    TaskModel(title: title, category: category, date: date??todayDate(), time: time);
    dueTasks = TasksList.instance.dueTasks;
    doneTasks = TasksList.instance.doneTasks;
    notifyListeners();
  }
}
