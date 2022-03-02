import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {
  final String title;
  const CallToAction({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
        style: TextButton.styleFrom(
            backgroundColor: Colors.green, primary: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ));
  }
}
