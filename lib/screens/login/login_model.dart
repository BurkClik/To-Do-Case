class LoginModel {
  final String status;
  final String token;
  final int userId;
  final String message;

  LoginModel({
    this.status,
    this.token,
    this.userId,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      token: json['token'],
      userId: json['userId'],
      message: json['message'],
    );
  }
}
