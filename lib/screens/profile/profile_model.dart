class ProfileModel {
  final String fullname;
  final String city;

  ProfileModel({this.fullname, this.city});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullname: json["data"][0]["fullname"],
      city: json["data"][0]["city"],
    );
  }
}
