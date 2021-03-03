import 'package:todo/screens/login/login_model.dart';

class LoginViewModel {
  final LoginModel loginModel;

  LoginViewModel({this.loginModel});

  String get status => this.loginModel.status;
  String get token => this.loginModel.token;
  int get userId => this.loginModel.userId;
  String get message => this.loginModel.message;
}
