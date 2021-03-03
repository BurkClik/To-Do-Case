import 'package:flutter/widgets.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/login/login_view.dart';
import 'package:todo/screens/todo/todo_view.dart';

final Map<String, WidgetBuilder> routes = {
  LoginView.routeName: (context) => LoginView(),
  TodoView.routeName: (context) => TodoView(),
  AuthWrapper.routeName: (context) => AuthWrapper()
};
