import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_lists.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:intl/intl.dart';

import '../common/constants.dart';

class AddTaskViewModel {
  final formKey = GlobalKey<FormState>();
  String? title;
  String? category;
  String? date;
  String? time;

  void updateTitle(String title) {
    this.title = title;
  }

  void updateCat(String category) {
    this.category = category;
  }

  void updateDate(String date) {
    this.date = date;
  }

  void updateTime(String time) {
    this.time = time;
  }

  bool addTask() {
    if (formKey.currentState!.validate()) {
      // TaskModel(
      //   title: title!,
      //   category: category??'assets/icons/ic_cat_task.svg',
      //   date: date??todayDate(),
      //   time: time
      // );
      return true;
    }
    return false;
  }

  String? validateRequired(dynamic value) {
    if (value.isEmpty) {
      return 'Required...';
    }
    return null;
  }
}
