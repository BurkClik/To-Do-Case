import 'package:flutter/material.dart';
import 'package:todo/screens/profile/profile_model.dart';
import 'package:todo/services/api_service.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<ProfileModel> profileModel;

  @override
  void initState() {
    super.initState();
    profileModel = fetchUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: FutureBuilder<ProfileModel>(
        future: profileModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 72,
                ),
                Text('${snapshot.data.fullname}'),
                snapshot.data.city == "empty"
                    ? ElevatedButton(
                        onPressed: () {},
                        child: Text('Konum Al'),
                      )
                    : Text('${snapshot.data.city}'),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
