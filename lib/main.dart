import 'package:flutter/material.dart';
import 'package:todo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: AuthWrapper.routeName,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  static String routeName = '/auth';
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkStatusLogin();
  }

  checkStatusLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    print(sharedPreferences.getInt("userId"));
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).popAndPushNamed('/login');
    } else {
      Navigator.of(context).popAndPushNamed('/todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
