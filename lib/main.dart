import 'package:flutter/material.dart';
import 'package:flutter_todo/common/tasks_provider.dart';
import 'package:flutter_todo/view/tasks_activity.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter'
        ),
        home: const TasksActivity(),
      ),
    );
  }
}
