import 'package:flutter/material.dart';
import 'package:todo/screens/home/home_view.dart';
import 'package:todo/screens/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/profile/profile_view.dart';

class TodoView extends StatefulWidget {
  static String routeName = '/todo';
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  SharedPreferences sharedPreferences;

  List<Widget> _viewList = [HomeView(), ProfileView()];
  int _currentViewList = 0;

  void initState() {
    super.initState();
    getValues();
  }

  getValues() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.black),
              onPressed: () {
                sharedPreferences.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginView()),
                    (Route<dynamic> route) => false);
              },
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: _currentViewList,
          onTap: (currentIndex) {
            setState(() {
              _currentViewList = currentIndex;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profil'),
          ],
        ),
        body: _viewList[_currentViewList]);
  }
}
