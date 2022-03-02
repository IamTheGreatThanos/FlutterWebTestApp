import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Container(
        color: Colors.white,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 160,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  _NavBarItem('Amount'),
                  SizedBox(
                    width: 40,
                  ),
                  _NavBarItem('News'),
                  SizedBox(
                    width: 40,
                  ),
                  _NavBarItem('Episodes'),
                  SizedBox(
                    width: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: _NavBarItem('About'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: Colors.blue[800],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.blue[800],
        )
      ],
    );
  }
}
