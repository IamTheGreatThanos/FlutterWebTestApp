import 'package:flutter/material.dart';
import 'package:test_web_app/views/authorization/login_view.dart';
import 'package:test_web_app/views/authorization/registration_view.dart';
import 'package:test_web_app/views/home/home_view.dart';
import 'package:test_web_app/views/main/main_view.dart';
import 'package:test_web_app/views/profile/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/login': (context) => LoginView(),
        '/registration': (context) => RegistrationView(),
        '/profile': (context) => ProfileView(),
        '/main': (context) => MainView(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: 'Montserrat')),
      // home: const HomeView()
    );
  }
}
