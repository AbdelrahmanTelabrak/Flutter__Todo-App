import 'package:flutter_todo/common/constants.dart';
import 'package:flutter_todo/common/database.dart';
import 'package:flutter_todo/model/task_model.dart';

class TasksRepository {
  final sqlDB = SqlDB();

  void insertTask({
    required String title,
    String? category,
    String? date,
    String? time,
  }) async {
    int result = await sqlDB.insertData('''
      INSERT INTO tasks(title, category, date, time, isDone)
      VALUES(?, ?, ?, ?, ?)
    ''', [
      title,
      category ?? 'assets/icons/ic_cat_task.svg',
      date ?? todayDate(),
      time,
      0
    ]);
    print('insert result: $result');
  }

  Future<List<TaskModel>> getAllTasks() async {
    final maps = await sqlDB.readData('SELECT * FROM tasks');
    return List.generate(maps.length, (i) {
      return TaskModel.fromJson(maps[i] as Map<String, dynamic>);
    });
  }

  void updateTask(TaskModel task) async {
    print(task.isDone);
    int result = await sqlDB.updateData('''
      UPDATE tasks 
      SET title = ?, category = ?, date = ?, time = ?, isDone = ?
      WHERE id = ?
    ''', [
      task.title,
      task.category,
      task.date,
      task.time,
      task.isDone ? 1 : 0,
      task.id
    ]);
    print(result);
  }

  void removeTask(TaskModel task) async {
    print('Repo task id: ${task.id}, task title: ${task.title}');
    int result = await sqlDB.deleteData('DELETE FROM tasks WHERE id = ?', [task.id]);
    print('delete result: $result');
  }
}
