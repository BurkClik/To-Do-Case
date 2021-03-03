import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/home/home_view.dart';
import 'package:todo/screens/login/login_model.dart';
import 'package:todo/screens/profile/profile_model.dart';
import 'package:todo/screens/todo/todo_model.dart';

/// If response status code is equal to 200,
/// we can reach to the infos of user.
///
/// Throw an [Exception] if response status code is equal to 404
Future<ProfileModel> fetchUserInfos() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final token = sharedPreferences.getString("token");
  final userId = sharedPreferences.getInt("userId");

  final response = await http
      .get(Uri.https('aodapi.eralpsoftware.net', 'user/$userId'), headers: {
    "token": token,
  });

  if (response.statusCode == 200) {
    print(response.body);
    return ProfileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

/// If [username] and [password] is valid, login is successfull
/// and token and userId have been saved by [SharedPrefences]
///
/// Throws an [Exception] if response status code is equal to 404
Future<LoginModel> fetchLoginInfo(
    {String username, String password, BuildContext context}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response =
      await http.post("https://aodapi.eralpsoftware.net/login/apply",
          body: jsonEncode({
            'username': username,
            'password': password,
          }),
          headers: {
        "content-type": "application/json",
      });

  if (response.statusCode == 200) {
    sharedPreferences.setString("token", json.decode(response.body)["token"]);
    sharedPreferences.setInt("userId", json.decode(response.body)["userId"]);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => HomeView()),
        (Route<dynamic> route) => false);
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    throw new Exception("Failed to load login status");
  }
}

postNewTodo({String name, String date, BuildContext context}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final response = await http.post(
    Uri.https('aodapi.eralpsoftware.net', 'todo'),
    headers: {
      "content-type": "application/json",
      "token": sharedPreferences.getString("token"),
    },
    body: jsonEncode(
      {
        'name': name,
        'date': date,
      },
    ),
  );

  if (response.statusCode == 200) {
    print(response.body);
    Navigator.of(context).pop();
  } else {
    throw new Exception("Failed to load todo post");
  }
}

Future<TodoModel> getAllTodos() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.https('aodapi.eralpsoftware.net', 'todo'),
    headers: {
      "token": sharedPreferences.getString("token"),
    },
  );

  if (response.statusCode == 200) {
    return TodoModel.fromJson(jsonDecode(response.body));
  } else {
    throw new Exception("Failed to load todo model");
  }
}

deleteTodo(int todoId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final response = await http.delete(
      Uri.https('aodapi.eralpsoftware.net', 'todo/$todoId'),
      headers: {"token": sharedPreferences.getString("token")});

  if (response.statusCode == 200) {
    print(response.statusCode);
  }
}
