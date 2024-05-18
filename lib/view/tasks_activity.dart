import 'package:floating_menu_panel/floating_menu_panel.dart';
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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../common/constants.dart';

class TasksActivity extends StatefulWidget {
  const TasksActivity({super.key});

  @override
  State<TasksActivity> createState() => _TasksActivityState();
}

class _TasksActivityState extends State<TasksActivity> {
  final List<IconData> icons = [
    Icons.all_inclusive_outlined,
    Icons.article_outlined,
    Icons.event_rounded,
    Icons.emoji_events_outlined,
  ];

  int _selectedIcon = 0;

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
            showDragHandle: true,
            // useSafeArea: true,
            backgroundColor: const Color(0xffF1F5F9),
            builder: (context) {
              return const AddTaskBottomSheet();
            },
          ),
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
                  TextButton(
                    onPressed: () {
                      showDialog<Widget>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                              width: 300, // Adjust width as needed
                              height: 400, // Adjust height as needed
                              child: SfDateRangePicker(
                                backgroundColor: Colors.white,
                                view: DateRangePickerView.month,
                                showTodayButton: true,
                                showActionButtons: true,
                                initialSelectedDate: DateTime.now(),
                                // Set today's date as initially selected
                                onSubmit: (value) {
                                  String formattedDate =
                                      DateFormat('MMMM dd, yyyy').format(
                                          DateTime.parse(value.toString()));
                                  if (formattedDate == todayDate()) {
                                    Provider.of<TasksProvider>(context,
                                            listen: false)
                                        .getTodayTask();
                                  } else {
                                    Provider.of<TasksProvider>(context,
                                            listen: false)
                                        .getDateTask(formattedDate);
                                  }
                                  Provider.of<TasksProvider>(context,
                                          listen: false)
                                      .currentDate = formattedDate;
                                  Navigator.pop(context);
                                },
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: semiBoldText(
                        Provider.of<TasksProvider>(context).currentDate,
                        color: Colors.white,
                        fontSize: 16,
                        align: TextAlign.center),
                  ),
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
          FloatingMenuPanel(
            positionTop: 16.0, // Initial Top Position
            positionLeft: 0.0,
            size: 60,
            onPressed: (p0) {
              setState(() {
                _selectedIcon = p0;
              });
              Provider.of<TasksProvider>(context, listen: false).categoryTasks(_selectedIcon);
            },
            panelIcon: icons[_selectedIcon],
            buttons: icons,
            backgroundColor: const Color(0xff574589),
          ),
        ],
      ),
    );
  }

  Column completedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        semiBoldText('Completed',
            color: (Provider.of<TasksProvider>(context).dueTasks.isNotEmpty)
                ? Colors.black
                : Colors.white,
            align: TextAlign.start),
        const SizedBox(height: 24),
        const TasksListView(done: true),
      ],
    );
  }
}
