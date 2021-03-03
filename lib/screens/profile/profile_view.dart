import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/provider.dart';
import 'package:todo/screens/profile/profile_model.dart';
import 'package:todo/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<ProfileModel> profileModel;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    profileModel = fetchUserInfos();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No photo');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: FutureBuilder<ProfileModel>(
        future: profileModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print("as");
                      getImage();
                    },
                    child: CircleAvatar(
                      backgroundImage: _image != null
                          ? FileImage(_image)
                          : NetworkImage("https://source.unsplash.com/random"),
                      radius: 72,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data.username}',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    '${context.watch<LocationProvider>().loc}',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
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
