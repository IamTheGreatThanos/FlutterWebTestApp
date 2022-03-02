import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var username = 'Username';

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover)),
          child: Center(child: Text(username)),
        ),
      ),
    );
  }

  void getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('login')!;
    });
  }
}
