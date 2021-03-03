import 'package:flutter/material.dart';
import 'package:todo/screens/login/login_model.dart';
import 'package:todo/services/api_service.dart';

class LoginView extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<LoginModel> loginModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/demo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      'Hoşgeldiniz',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Parola",
                            hintStyle: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giriş Yap',
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Kanit',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                loginModel = fetchLoginInfo(
                                    username: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    context: context);
                              },
                              child: Icon(
                                Icons.chevron_right,
                                size: 40,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                minimumSize: Size(72, 72),
                                primary: Color(0xFF3F444E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
