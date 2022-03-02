import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'FLUTTER WEB \nTHE BASICS',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                height: 0.9,
                fontSize: 80,
                color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'In this course we will go over the basics of using Flutter Web for website development. Topics will include Responsive Layout, Deploying, Font Changes, Hover Functionality, Modals and more.',
            style: TextStyle(
                height: 0.9,
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
