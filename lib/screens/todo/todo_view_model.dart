import 'package:todo/screens/todo/todo_model.dart';

class TodoViewModel {
  final Todo todo;

  TodoViewModel({this.todo});

  String get name => this.todo.name;

  DateTime get date => this.todo.date;
}
