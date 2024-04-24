import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_lists.dart';
import 'package:flutter_todo/common/widgets/buttons.dart';
import 'package:flutter_todo/common/widgets/texts.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:flutter_todo/view/add_task.dart';
import 'package:flutter_todo/view/task_list.dart';
import 'package:intl/intl.dart';

import '../common/constants.dart';

class TasksActivity extends StatelessWidget {
  const TasksActivity({super.key});

  // List<TaskModel> firstFiveTasks = [
  //   TaskModel(
  //     title: 'Complete project proposal',
  //     category: 'assets/icons/ic_cat_task.svg',
  //     date: 'April 16, 2024',
  //     time: '10:00 AM',
  //   ),
  //   TaskModel(
  //     title: 'Buy groceries',
  //     category: 'assets/icons/ic_cat_event.svg',
  //     date: '2024-04-17',
  //     time: '4:00 PM',
  //   ),
  // ];
  //
  // List<TaskModel> lastFiveTasks = [
  //   TaskModel(
  //     title: 'Pay bills',
  //     category: 'assets/icons/ic_cat_goal.svg',
  //     date: '2024-04-21',
  //     time: '9:00 AM',
  //     isDone: true,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: fullWidthButton(
          child: boldText('Add New Task', color: Colors.white),
          onPressed: () => showModalBottomSheet(context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xffF1F5F9),
              builder: (context) {
                return const AddTaskBottomSheet();
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/header.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Today's date
                  const SizedBox(height: 36),
                  semiBoldText(todayDate(),
                      color: Colors.white,
                      fontSize: 12,
                      align: TextAlign.center),
                  //Title
                  const SizedBox(height: 42),
                  boldText('My Todo List',
                      fontSize: 30,
                      color: Colors.white,
                      align: TextAlign.center),
                  // Due Tasks
                  const SizedBox(height: 32),
                  const TasksListView(done: false),
                  // TasksListView(tasks: firstFiveTasks, updateTasks: updateTasks),
                  // Done Tasks
                  const SizedBox(height: 24),
                  semiBoldText('Completed',
                      color: Colors.black, align: TextAlign.start),
                  const SizedBox(height: 24),
                  const TasksListView(done: true),
                  // TasksListView(tasks: lastFiveTasks, updateTasks: updateTasks),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
