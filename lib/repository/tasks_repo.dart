import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/database.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:intl/intl.dart';

class TasksRepository {
  final sqlDB = SqlDB();

  void insertTask({
    required String title,
    String? category,
    String? date,
    String? time,
    int? priority,
    String? notes,
  }) async {
    int result = await sqlDB.insertData('''
      INSERT INTO tasks(title, category, date, time, isDone, priority, notes)
      VALUES(?, ?, ?, ?, ?, ?, ?)
    ''', [
      title,
      category ?? 'assets/icons/ic_cat_task.svg',
      date ?? todayDate(),
      time,
      0,
      priority,
      notes,
    ]);
    print('insert result: $result');
  }

  Future<List<TaskModel>> getAllTasks() async {
    final maps = await sqlDB.readData('SELECT * FROM tasks ORDER BY priority DESC');
    return List.generate(maps.length, (i) {
      return TaskModel.fromJson(maps[i] as Map<String, dynamic>);
    });
  }

  Future<List<TaskModel>> getTodayTasks() async {
    final maps = await sqlDB.readData('''SELECT * FROM tasks 
    ORDER BY priority DESC''');
    return List.generate(maps.length, (i) {
      return TaskModel.fromJson(maps[i] as Map<String, dynamic>);
    });
  }

  Future<List<TaskModel>> getDateTask(String date) async {
    final maps =
        await sqlDB.readData('SELECT * FROM tasks WHERE date = ? ORDER BY priority DESC', [date]);
    return List.generate(maps.length, (i) {
      return TaskModel.fromJson(maps[i] as Map<String, dynamic>);
    });
  }

  Future<List<TaskModel>> getRangeTasks(
      String startDate, String endDate) async {
    DateTime date1 = DateFormat('MMMM dd, yyyy').parse(startDate);
    DateTime date2 = DateFormat('MMMM dd, yyyy').parse(endDate);
    final List<Map<dynamic, dynamic>> maps = [];
    for (DateTime date = date1;
        date.isBefore(date2) || date.isAtSameMomentAs(date2);
        date = date.add(Duration(days: 1))) {
      // Format the date in 'MMMM dd, yyyy' format
      String formattedDate = DateFormat('MMMM dd, yyyy').format(date);
      sqlDB.readData('SELECT * FROM tasks WHERE date = ? ORDER BY priority DESC',
          [formattedDate]).then((value) => maps.addAll(value));
      print(formattedDate);
    }
    return List.generate(maps.length, (i) {
      return TaskModel.fromJson(maps[i] as Map<String, dynamic>);
    });
  }

  void updateTask(TaskModel task) async {
    print(task.isDone);
    int result = await sqlDB.updateData('''
      UPDATE tasks 
      SET title = ?, category = ?, date = ?, time = ?, isDone = ?, priority = ?, notes = ?
      WHERE id = ?
    ''', [
      task.title,
      task.category,
      task.date,
      task.time,
      task.isDone ? 1 : 0,
      task.priority,
      task.notes,
      task.id
    ]);
    print(result);
  }

  void removeTask(TaskModel task) async {
    print('Repo task id: ${task.id}, task title: ${task.title}');
    int result =
        await sqlDB.deleteData('DELETE FROM tasks WHERE id = ?', [task.id]);
    print('delete result: $result');
  }
}
