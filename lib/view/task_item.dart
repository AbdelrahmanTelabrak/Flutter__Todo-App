import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/widgets/texts.dart';
import 'package:flutter_todo/model/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final Function changeTaskState;
  const TaskItem({super.key, required this.task, required this.changeTaskState});

  bool isLate() {
    String today = todayDate();
    if (today == task.date) {
      return false;
    } else {
      return true;
    }
  }

  String subtitle() {
    String sub = '';
    if (task.time != null) {
      sub += task.time!;
      sub += '    ';
    }
    if (task.date != null) {
      sub += task.date!;
    }
    return sub;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: task.isDone ? 0.5 : 1.0,
      child: ListTile(
        leading: SvgPicture.asset(task.category!),
        title: semiBoldText(task.title!,
            color: isLate() ? Colors.red.shade800 : Colors.black),
        subtitle: subtitle().isNotEmpty
            ? mediumText(subtitle(),
                fontSize: 14,
                color: isLate() ? Colors.red.shade800 : Colors.black)
            : null,
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (newVal) {
            changeTaskState(task);
          },
          fillColor: MaterialStateColor.resolveWith((states) {
            return states.contains(MaterialState.selected)
                ? const Color(0xff4A3780)
                : Colors.transparent;
          }),
        ),
      ),
    );
  }
}
