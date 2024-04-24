import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_provider.dart';
import 'package:flutter_todo/view/task_item.dart';
import 'package:provider/provider.dart';

import '../model/task_model.dart';

class TasksListView extends StatelessWidget {
  final bool done;

  const TasksListView({super.key, required this.done});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.only(
              bottom: (done ? value.doneTasks.isEmpty : value.dueTasks.isEmpty)
                  ? 0
                  : 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => TaskItem(
                    task: (done ? value.doneTasks[index] : value.dueTasks[index]),
                    changeTaskState: (task){
                      value.updateTask(task);
                    },
                  ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  (done ? value.doneTasks.length : value.dueTasks.length)),
        );
      },
    );
  }
}
