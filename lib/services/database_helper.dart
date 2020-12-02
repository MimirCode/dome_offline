import 'package:dome_offline/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dome_offline/models/todo_model.dart';

class DatabaseHelper {
  Future<Database> createDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dome.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, taskTitle TEXT, description TEXT)");
        await db.execute(
            "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, todoTitle TEXT, isDone INTEGER)");

        return db;
      },
      version: 1,
    );
  }

  // ignore: missing_return
  //insert a task
  Future<int> insertTask(TaskModel taskModel) async {
    int taskId = 0;
    Database _db = await createDatabase();
    await _db
        .insert('tasks', taskModel.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  //Update task
  Future<void> updateTaskTitle(int id, String taskTitle) async {
    Database _db = await createDatabase();
    await _db.rawUpdate(
        "UPDATE tasks SET taskTitle = '$taskTitle' WHERE id = '$id'");
  }

  //insert a todo
  Future<void> insertTodo(TodoModel todoModel) async {
    Database _db = await createDatabase();
    await _db.insert('todo', todoModel.toMap(),
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

  Future<List<TodoModel>> getTodos(int taskId) async {
    Database _db = await createDatabase();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery('SELECT * FROM todo WHERE taskId = $taskId');
    return List.generate(todoMap.length, (index) {
      return TodoModel(
        id: todoMap[index]['id'],
        taskId: todoMap[index]['taskId'],
        todoTitle: todoMap[index]['todoTitle'],
        isDone: todoMap[index]['isDone'],
      );
    });
  }
}
