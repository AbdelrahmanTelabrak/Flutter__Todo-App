import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todo/common/widgets/texts.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  final Function updateTasks;

  const TaskItem({super.key, required this.task, required this.updateTasks});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isLate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    // DateFormat formatter = DateFormat('yyyy-mm-dd');
    String formatted = formatter.format(now);
    if (widget.task.date == null) {
      return false;
    }
    if (formatted == widget.task.date) {
      return false;
    } else {
      return true;
    }
  }

  String subtitle() {
    String sub = '';
    if (widget.task.time != null) {
      sub += widget.task.time!;
      sub += '    ';
    }
    if (widget.task.date != null) {
      sub += widget.task.date!;
    }
    return sub;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.task.isDone ? 0.5 : 1.0,
      child: ListTile(
        leading: SvgPicture.asset(widget.task.category!),
        title: semiBoldText(widget.task.title!,
            color: isLate() ? Colors.red.shade800 : Colors.black),
        subtitle: subtitle().isNotEmpty
            ? mediumText(subtitle(),
                fontSize: 14,
                color: isLate() ? Colors.red.shade800 : Colors.black)
            : null,
        trailing: Checkbox(
          value: widget.task.isDone,
          onChanged: (newVal) {
            setState(() {
              widget.task.changeStatus();
              widget.updateTasks();
            });
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
