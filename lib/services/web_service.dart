import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/todo/todo_view.dart';

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
        MaterialPageRoute(builder: (BuildContext context) => TodoView()),
        (Route<dynamic> route) => false);
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    throw new Exception("response code: ${response.statusCode}");
  }
}
