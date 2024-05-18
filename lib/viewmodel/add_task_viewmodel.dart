import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:flutter_todo/repository/tasks_repo.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/tasks_provider.dart';

class AddTaskViewModel {
  final taskRepo = TasksRepository();
  final formKey = GlobalKey<FormState>();
  String? title;
  String? category;
  String? date;
  String? time;
  int? priority;
  String? notes;

  void updateTitle(String title) {
    this.title = title;
  }

  void updateCat(String category) {
    this.category = category;
  }

  void updateDate(String date) {
    print("This date: $date");
    this.date = date;
  }

  void updateTime(String time) {
    this.time = time;
  }

  void updatePriority(String priority) {
    print('priority = $priority');
    this.priority = int.parse(priority);
  }

  void updateNote(String notes) {
    this.notes = notes;
  }

  void addTask(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Provider.of<TasksProvider>(context, listen: false).addTask(
        title: title!,
        category: category ?? 'assets/icons/ic_cat_task.svg',
        date: date ?? todayDate(),
        time: time,
        priority: priority,
        notes: notes,
      );
      Navigator.pop(context);
    }
  }

  String? validateRequired(dynamic value) {
    if (value.isEmpty) {
      return 'Required...';
    }
    return null;
  }
}
