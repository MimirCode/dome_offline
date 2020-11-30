import 'dart:ffi';

import 'package:dome_offline/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> createDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dome.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, taskTitle TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  // ignore: missing_return
  Future<Void> insertTask(TaskModel taskModel) async {
    Database _db = await createDatabase();
    await _db.insert('tasks', taskModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskModel>> getTasks() async {
    Database _db = await createDatabase();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return TaskModel(
        id: taskMap[index]['id'],
        taskTitle: taskMap[index]['taskTitle'],
        description: taskMap[index]['description'],
      );
    });
  }
}
