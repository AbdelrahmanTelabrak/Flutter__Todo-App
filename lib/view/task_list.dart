import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_provider.dart';
import 'package:flutter_todo/view/task_item.dart';
import 'package:provider/provider.dart';

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
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Dismissible(
              key: ValueKey(
                  (done ? value.doneTasks[index] : value.dueTasks[index]).id),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                done
                    ? Provider.of<TasksProvider>(context, listen: false)
                        .removeTask(value.doneTasks[index])
                    : Provider.of<TasksProvider>(context, listen: false)
                        .removeTask(value.dueTasks[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: (index !=
                              (done
                                  ? value.doneTasks.length - 1
                                  : value.dueTasks.length - 1))
                          ? BorderSide(color: Colors.grey.shade400)
                          : BorderSide.none),
                ),
                child: TaskItem(
                  task: (done ? value.doneTasks[index] : value.dueTasks[index]),
                  changeTaskState: (task) {
                    value.updateTask(task);
                  },
                ),
              ),
            ),
            // separatorBuilder: (context, index) => const Divider(),
            itemCount: (done ? value.doneTasks.length : value.dueTasks.length),
          ),
        );
      },
    );
  }
}
