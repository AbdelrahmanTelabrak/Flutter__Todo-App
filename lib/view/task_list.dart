import 'package:flutter/material.dart';
import 'package:flutter_todo/view/task_item.dart';

import '../model/task_model.dart';

class TasksListView extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function updateTasks;

  const TasksListView(
      {super.key, required this.tasks, required this.updateTasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: tasks.isEmpty? 0: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              TaskItem(task: tasks[index], updateTasks: updateTasks),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: tasks.length),
    );
  }
}
