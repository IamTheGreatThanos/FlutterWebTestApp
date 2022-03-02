import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/services/auth_api_provider.dart';
import 'package:test_web_app/utils/const.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg-auth.jpg'),
              fit: BoxFit.cover)),
      child: Center(
          child: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(30)),
            width: 400,
            height: 530,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    color: Colors.green,
                    width: 400,
                    height: 80,
                    child: const Center(
                      child: Text(
                        'Авторизация',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.follow_the_signs,
                      color: Colors.white,
                      size: 50,
                    ),
                    radius: 50,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextFormField(
                    controller: loginController,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Введите логин',
                        labelText: 'Логин',
                        labelStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 16),
                        prefixText: ' ',
                        // suffixText: 'USD',
                        suffixStyle:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Пароль',
                        labelText: 'Пароль',
                        labelStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 16),
                        prefixText: ' ',
                        // suffixText: 'USD',
                        suffixStyle:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: TextButton(
                    child: const Text(
                      "ВОЙТИ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      if (loginController.text != '' &&
                          passwordController.text != '') {
                        login();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Заполните поля корректно...",
                              style: TextStyle(fontSize: 16)),
                        ));
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      primary: Colors.white,
                      onSurface: Colors.white,
                      backgroundColor: Colors.green,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'У вас нет аккаунта?  ',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/registration');
                        },
                        child: const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                              color: Colors.yellow,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      )),
    ));
  }

  void login() async {
    var response = await AuthProvider()
        .login(loginController.text, passwordController.text);
    if (response['status'] == 'ok') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['data']['token']);
      prefs.setString('login', response['data']['username']);
      prefs.setInt('uid', response['data']['user_id']);
      AppConstants().isLogedIn = true;
      Navigator.of(context).pushNamed('/main');
    }
  }
}
