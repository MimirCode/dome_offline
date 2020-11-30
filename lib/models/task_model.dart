class TaskModel {
  //Properties
  final int id;
  final String taskTitle;
  final String description;

  //Constructor
  TaskModel({this.id, this.taskTitle, this.description});

  //Methods
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'description': description,
    };
  }
}
