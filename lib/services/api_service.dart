import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/profile/profile_model.dart';

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
    throw Exception('Failed to load album');
  }
}
