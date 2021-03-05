import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/provider.dart';
import 'package:todo/screens/login/login_view.dart';
import 'package:todo/screens/profile/profile_view.dart';
import 'package:todo/screens/todo/todo_view.dart';
import 'package:todo/services/api_service.dart';
import 'package:todo/services/location.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/home';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SharedPreferences sharedPreferences;
  LocationPermission permissionControl;

  void initState() {
    super.initState();
    getValues();
  }

  getValues() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void getLocation() async {
    Location location = new Location();
    await location.getLocation();

    LocationPermission permission = await Geolocator.checkPermission();
    permissionControl = permission;
    print(location.adArea);
    setState(() {
      context.read<LocationProvider>().changeLoc(location.adArea);
    });
  }

  List<Widget> _viewList = [TodoView(), ProfileView()];
  int _currentViewList = 0;

  TextEditingController todoNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFFF7F6F1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () async {
            await addTodo(context);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: _currentViewList == 1
              ? IconButton(
                  onPressed: () {
                    getLocation();
                  },
                  icon: Icon(
                    Icons.navigation,
                    color: Colors.black,
                  ),
                )
              : null,
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
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _currentViewList,
            onTap: (currentIndex) {
              setState(() {
                _currentViewList = currentIndex;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Anasayfa'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: 'Profil'),
            ],
          ),
        ),
        body: _viewList[_currentViewList]);
  }

  addTodo(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Yeni Görev')),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextFormField(
                    controller: todoNameController,
                    decoration: InputDecoration(
                      hintText: 'Görev Ekle',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await postNewTodo(
                        name: todoNameController.text,
                        date: DateTime.now().toIso8601String(),
                        context: context,
                      );
                      todoNameController.clear();
                    },
                    child: Text('Yeni Todo'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF9D73),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
