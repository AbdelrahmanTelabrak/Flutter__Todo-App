import 'package:flutter/material.dart';
import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/tasks_lists.dart';
import 'package:flutter_todo/repository/tasks_repo.dart';

import '../model/task_model.dart';

class TasksProvider extends ChangeNotifier {
  final tasksRepo = TasksRepository();
  List<TaskModel> dueTasks = TasksList.instance.dueTasks;
  List<TaskModel> doneTasks = TasksList.instance.doneTasks;
  List<TaskModel> allTasks = [];
  List<String> categories = [
    '',
    'assets/icons/ic_cat_task.svg',
    'assets/icons/ic_cat_event.svg',
    'assets/icons/ic_cat_goal.svg'
  ];
  String currentDate = todayDate();

  void getAllTasks() async {
    dueTasks.clear();
    doneTasks.clear();
    allTasks.clear();
    allTasks = await tasksRepo.getAllTasks();
    allTasks.map((e) => e.isDone
        ? (e.date != todayDate())
            ? doneTasks.add(e)
            : doneTasks.remove(e)
        : dueTasks.add(e));
    notifyListeners();
  }

  void getDateTask(String date) async {
    dueTasks.clear();
    doneTasks.clear();
    allTasks.clear();
    allTasks = await tasksRepo.getDateTask(date);
    allTasks.map((e) => e.isDone
        ? (e.date != todayDate())
            ? doneTasks.add(e)
            : doneTasks.remove(e)
        : dueTasks.add(e));
    notifyListeners();
  }

  void getRangeTasks(String startDate, String endDate) async {
    dueTasks.clear();
    doneTasks.clear();
    allTasks.clear();
    allTasks = await tasksRepo.getRangeTasks(startDate, endDate);
    allTasks.map((e) => e.isDone
        ? (e.date != todayDate())
            ? doneTasks.add(e)
            : doneTasks.remove(e)
        : dueTasks.add(e));
    notifyListeners();
  }

  void getTodayTask() async {
    dueTasks.clear();
    doneTasks.clear();
    allTasks.clear();
    allTasks = await tasksRepo.getAllTasks();
    allTasks.map((e) => e.isDone
        ? (e.date != todayDate())
            ? doneTasks.add(e)
            : doneTasks.remove(e)
        : dueTasks.add(e));
    notifyListeners();
  }

  void updateTask(TaskModel task, bool statChange) async {
    if (statChange) {
      task.changeStatus();
    }
    dueTasks.clear();
    doneTasks.clear();
    allTasks.clear();
    tasksRepo.updateTask(task);
    if (currentDate == todayDate()) {
      allTasks = await tasksRepo.getTodayTasks();
    } else {
      allTasks = await tasksRepo.getDateTask(currentDate);
    }
    allTasks.map((e) => e.isDone
        ? (e.date != todayDate())
            ? doneTasks.add(e)
            : doneTasks.remove(e)
        : dueTasks.add(e));
    notifyListeners();
  }

  void addTask({
    required String title,
    required String category,
    String? date,
    String? time,
    int? priority,
    String? notes,
  }) {
    tasksRepo.insertTask(
      title: title,
      category: category ?? 'assets/icons/ic_cat_task.svg',
      date: date ?? todayDate(),
      time: time,
      priority: priority,
      notes: notes,
    );
    getAllTasks();
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    tasksRepo.removeTask(task);
    if (task.isDone) {
      doneTasks.removeWhere((element) => element.id == task.id);
    } else {
      print('task title: ${task.title}');
      dueTasks.removeWhere((element) => element.id == task.id);
    }
    notifyListeners();
  }

  void categoryTasks(int catIndex) {
    dueTasks.clear();
    doneTasks.clear();
    print('Selected category: ${categories[catIndex]}');
    if (catIndex == 0) {
      print('ALL TASKS');
      print(allTasks);
      for (var e in allTasks) {
        print('Task Title: ${e.title}, Category: ${e.category}');
        if (e.isDone) {
          doneTasks.add(e);
        } else {
          dueTasks.add(e);
        }
        print(doneTasks);
        print(dueTasks);
      }
      print(doneTasks);
      print(dueTasks);
    } else {
      print(allTasks);
      for (var e in allTasks) {
        print('Task Title: ${e.title}, Category: ${e.category}');
        if (e.category == categories[catIndex]) {
          print(e.title);
          if (e.isDone) {
            doneTasks.add(e);
          } else {
            dueTasks.add(e);
          }
          print(doneTasks);
          print(dueTasks);
        }
      }
    }
    notifyListeners();
  }
}
