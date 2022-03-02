import 'package:flutter/material.dart';
import 'package:test_web_app/utils/const.dart';
import 'package:test_web_app/views/main/main_view.dart';
import 'package:test_web_app/widgets/call_to_action/call_to_action.dart';
import 'package:test_web_app/widgets/course_details/course_details.dart';
import 'package:test_web_app/widgets/navigation_bar/navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return AppConstants().isLogedIn
        ? Scaffold(
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg.jpg'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: NavigationBar(),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: Row(
                          children: const [
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50),
                                  child: CourseDetails(),
                                )),
                            Expanded(
                                child: Center(
                              child: CallToAction(title: 'Join Course'),
                            ))
                          ],
                        )),
                    // SizedBox(
                    //     height: 400,
                    //     child: Row(
                    //       children: const [
                    //         Expanded(
                    //             flex: 2,
                    //             child: Padding(
                    //               padding: EdgeInsets.symmetric(vertical: 50),
                    //               child: CourseDetails(),
                    //             )),
                    //         Expanded(
                    //             child: Center(
                    //           child: CallToAction(title: 'Join Course'),
                    //         ))
                    //       ],
                    //     )),
                    // SizedBox(
                    //     height: 400,
                    //     child: Row(
                    //       children: const [
                    //         Expanded(
                    //             flex: 2,
                    //             child: Padding(
                    //               padding: EdgeInsets.symmetric(vertical: 50),
                    //               child: CourseDetails(),
                    //             )),
                    //         Expanded(
                    //             child: Center(
                    //           child: CallToAction(title: 'Join Course'),
                    //         ))
                    //       ],
                    //     )),
                  ],
                ),
              ),
            ),
          )
        : MainView();
  }
}
