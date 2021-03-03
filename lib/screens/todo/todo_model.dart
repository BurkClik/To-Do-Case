class TodoModel {
  final int id;
  final int count;
  final String name;
  final String date;
  final List todoList;

  TodoModel({this.id, this.count, this.name, this.date, this.todoList});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["body"][2]["id"],
      count: json["count"],
      name: json["body"][2]["name"],
      date: json["body"][2]["date"],
      todoList: json["body"],
    );
  }
}
