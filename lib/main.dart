import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider.dart';
import 'package:todo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> searchResult = new List();
  final String loc = "";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<SearchProvider>(
            create: (_) => SearchProvider(searchResult)),
        ListenableProvider<LocationProvider>(
            create: (_) => LocationProvider(loc)),
      ],
      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: AuthWrapper.routeName,
      ),
    );
  }
}

/// The Widget check the token is null or not.
/// If the token is null, navigate to the [LoginView]
/// If the token is not null, navigate to the [TodoView]
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
      Navigator.of(context).popAndPushNamed('/home');
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
