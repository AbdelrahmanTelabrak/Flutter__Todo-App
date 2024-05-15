import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_lists.dart';

class TaskModel {
  int? id;
  String? title;
  String? category;
  String? date;
  String? time;
  bool isDone;

  TaskModel(
      {this.id,
      required this.title,
      this.category,
      this.date,
      this.time,
      this.isDone = false}) {
    if (isDone) {
      TasksList.instance.doneTasks.add(this);
    } else {
      TasksList.instance.dueTasks.add(this);
    }
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      date: map['date'],
      time: map['time'],
      isDone: map['isDone'] == 1 ? true : false,
    );
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
