import 'package:flutter/material.dart';
import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/tasks_lists.dart';
import 'package:flutter_todo/repository/tasks_repo.dart';

import '../model/task_model.dart';

class TasksProvider extends ChangeNotifier {
  final tasksRepo = TasksRepository();
  List<TaskModel> dueTasks = TasksList.instance.dueTasks;
  List<TaskModel> doneTasks = TasksList.instance.doneTasks;

  void getAllTasks() async {
    dueTasks.clear();
    doneTasks.clear();
    final tasks = await tasksRepo.getAllTasks();
    tasks.map((e) => e.isDone
        ? (e.date != todayDate())
            ? doneTasks.add(e)
            : doneTasks.remove(e)
        : dueTasks.add(e));
    notifyListeners();
  }

  void updateTask(TaskModel task) {
    task.changeStatus();
    dueTasks = TasksList.instance.dueTasks;
    doneTasks = TasksList.instance.doneTasks;
    tasksRepo.updateTask(task);
    notifyListeners();
  }

  void addTask({
    required String title,
    required String category,
    String? date,
    String? time,
  }) {
    tasksRepo.insertTask(
      title: title,
      category: category ?? 'assets/icons/ic_cat_task.svg',
      date: date ?? todayDate(),
      time: time,
    );
    getAllTasks();
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    tasksRepo.removeTask(task);
    if (task.isDone) {
      doneTasks.removeWhere((element) => element.id == task.id);
    }
    else {
      print('task title: ${task.title}');
      dueTasks.removeWhere((element) => element.id == task.id);
    }
    notifyListeners();
  }
}
