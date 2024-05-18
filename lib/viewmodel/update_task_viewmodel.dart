import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/tasks_provider.dart';
import '../repository/tasks_repo.dart';

class UpdateTaskViewModel {
  final taskRepo = TasksRepository();
  final formKey = GlobalKey<FormState>();
  final TaskModel taskModel;

  UpdateTaskViewModel(this.taskModel);

  void updateTitle(String title) {
    taskModel.title = title;
  }

  void updateCat(String category) {
    taskModel.category = category;
  }

  void updateDate(String date) {
    print("This date: $date");
    taskModel.date = date;
  }

  void updateTime(String time) {
    taskModel.time = time;
  }

  void updatePriority(String priority) {
    print('priority = $priority');
    taskModel.priority = int.parse(priority);
  }

  void updateNote(String notes) {
    taskModel.notes = notes;
  }

  void updateTask(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Provider.of<TasksProvider>(context, listen: false).updateTask(taskModel, false);
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
