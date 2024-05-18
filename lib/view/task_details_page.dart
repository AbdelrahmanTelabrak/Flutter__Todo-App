import 'package:flutter/material.dart';
import 'package:flutter_todo/common/widgets/buttons.dart';
import 'package:flutter_todo/common/widgets/texts.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:flutter_todo/view/priority_selector.dart';
import 'package:flutter_todo/viewmodel/update_task_viewmodel.dart';

import '../common/widgets/textfields.dart';
import 'cat_selector.dart';

class TaskDetailsPage extends StatefulWidget {
  final TaskModel task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late final UpdateTaskViewModel _viewModel;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = UpdateTaskViewModel(widget.task);
    _dateController.text = widget.task.date!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      body: SingleChildScrollView(
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 96,
                    child: Stack(
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
                        AppBar(
                          backgroundColor: Colors.transparent,
                          title: semiBoldText('Task Details',
                              color: Colors.white, fontSize: 16),
                          centerTitle: true,
                          toolbarHeight: 96,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        semiBoldText('Task Title',
                            fontSize: 14, align: TextAlign.start),
                        const SizedBox(height: 8),
                        basicFormField(
                          hint: 'Task Title',
                          validator: _viewModel.validateRequired,
                          onChanged: _viewModel.updateTitle,
                          initialValue: widget.task.title,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            semiBoldText('Category', fontSize: 14),
                            const SizedBox(width: 24),
                            SizedBox(
                              height: 50,
                              child: CategorySelector(
                                chooseCat: (iconPath) {
                                  setState(() {});
                                  _viewModel.updateCat(iconPath);
                                  print(iconPath);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            semiBoldText('Priority    ', fontSize: 14),
                            const SizedBox(width: 24),
                            SizedBox(
                              height: 50,
                              child: PrioritySelector(
                                choosePriority: (priority) {
                                  setState(() {});
                                  _viewModel.updatePriority(priority);
                                  print(priority);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // PrioritySelector(choosePriority: _viewModel.updatePriority),
                        semiBoldText('Date',
                            fontSize: 14, align: TextAlign.start),
                        const SizedBox(height: 8),
                        datePickerFormField(
                          context: context,
                          controller: _dateController,
                          onUpdate: () {
                            setState(() {});
                          },
                          onChanged: _viewModel.updateDate,
                        ),
                        const SizedBox(height: 24),
                        semiBoldText('Task Notes',
                            fontSize: 14, align: TextAlign.start),
                        const SizedBox(height: 8),
                        basicFormField(
                          hint: 'Notes',
                          minLines: 3,
                          onChanged: _viewModel.updateNote,
                          initialValue: widget.task.notes,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: fullWidthButton(
                  child: boldText('Update Task', color: Colors.white),
                  onPressed: () => _viewModel.updateTask(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
