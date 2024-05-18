import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/widgets/texts.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_todo/view/task_details_page.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final Function changeTaskState;

  const TaskItem(
      {super.key, required this.task, required this.changeTaskState});

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
    // print(task.title!);
    print('Task title: ${task.title}, Priority: ${task.priority}');
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailsPage(task: task),));
      },
      child: Opacity(
        opacity: task.isDone ? 0.5 : 1.0,
        child: ListTile(
          leading: badges.Badge(
            badgeStyle: badges.BadgeStyle(
              badgeColor: getPrioColor(((task.priority) ?? 1).toString()),
            ),
            badgeContent:
                regularText(' ', color: Colors.white),
            child:
                SvgPicture.asset(task.category ?? 'assets/icons/ic_cat_task.svg'),
          ),
          title: semiBoldText(task.title!,
              color: isLate(task.date!) ? Colors.red.shade800 : Colors.black),
          subtitle: subtitle().isNotEmpty
              ? mediumText(subtitle(),
                  fontSize: 14,
                  color: isLate(task.date!) ? Colors.red.shade800 : Colors.black)
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
      ),
    );
  }

  Color getPrioColor(String pr){
    if (pr == '1') {
      return const Color(0xffe1fcd1);
    }
    else if (pr == '2') {
      return const Color(0xfffcf3d1);
    }
    return const Color(0xFFFFB0B0);
  }
}
