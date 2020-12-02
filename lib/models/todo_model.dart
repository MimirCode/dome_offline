class TodoModel {
  final int id;
  final String todoTitle;
  final int isDone;
  final int taskId;

  TodoModel({
    this.id,
    this.taskId,
    this.todoTitle,
    this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskID': taskId,
      'todoTitle': todoTitle,
      'isDone': isDone,
    };
  }
}
