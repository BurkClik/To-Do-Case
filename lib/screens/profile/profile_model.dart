class ProfileModel {
  final String username;
  final String city;

  ProfileModel({this.username, this.city});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json["data"][0]["username"],
      city: json["data"][0]["city"],
    );
  }
}
