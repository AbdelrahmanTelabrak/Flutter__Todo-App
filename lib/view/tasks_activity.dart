import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_lists.dart';
import 'package:flutter_todo/common/tasks_provider.dart';
import 'package:flutter_todo/common/widgets/buttons.dart';
import 'package:flutter_todo/common/widgets/texts.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:flutter_todo/view/add_task.dart';
import 'package:flutter_todo/view/task_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

class TasksActivity extends StatelessWidget {
  const TasksActivity({super.key});
  @override
  Widget build(BuildContext context) {
    // Provider.of<TasksProvider>(context, listen: false).getAllTasks();
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: fullWidthButton(
          child: boldText('Add New Task', color: Colors.white),
          onPressed: () => showModalBottomSheet(
              context: context,
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
                  if (Provider.of<TasksProvider>(context).dueTasks.isNotEmpty)
                    const Column(
                      children: [
                        SizedBox(height: 32),
                        TasksListView(done: false),
                      ],
                    ),
                  // TasksListView(tasks: firstFiveTasks, updateTasks: updateTasks),
                  // Done Tasks
                  if (Provider.of<TasksProvider>(context).doneTasks.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        semiBoldText('Completed',
                            color: (Provider.of<TasksProvider>(context)
                                .dueTasks
                                .isNotEmpty)
                                ? Colors.black
                                : Colors.white,
                            align: TextAlign.start),
                        const SizedBox(height: 24),
                        const TasksListView(done: true),
                      ],
                    ),
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

  Column completedSection(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        semiBoldText('Completed',
            color: (Provider.of<TasksProvider>(context)
                .dueTasks
                .isNotEmpty)
                ? Colors.black
                : Colors.white,
            align: TextAlign.start),
        const SizedBox(height: 24),
        const TasksListView(done: true),
      ],
    );
  }
}
