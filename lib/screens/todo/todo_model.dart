class Todo {
  final String name;
  final DateTime date;

  Todo({this.name, this.date});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      name: json["name"],
      date: json["date"],
    );
  }
}
