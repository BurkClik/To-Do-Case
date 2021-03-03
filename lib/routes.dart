import 'package:flutter/widgets.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/login/login_view.dart';
import 'package:todo/screens/home/home_view.dart';

final Map<String, WidgetBuilder> routes = {
  LoginView.routeName: (context) => LoginView(),
  HomeView.routeName: (context) => HomeView(),
  AuthWrapper.routeName: (context) => AuthWrapper()
};
