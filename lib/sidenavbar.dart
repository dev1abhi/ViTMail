import 'package:flutter/material.dart';

class SideNavBar extends StatefulWidget {
  final String userName;

  const SideNavBar({required this.userName});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    
    final firstName = widget.userName.split(' ')[0];

    return Drawer(
        width: 240,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(74),
            bottomRight: Radius.circular(74),
          ),
        ),
        backgroundColor: Color(0xFF213555),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 73.83,
              child: Icon(
                Icons.account_circle,
                size: 75,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 190,
              left: 63,
              child: Text(
                firstName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 261),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        print('Home Button Pressed');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Inbox',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        print('Inbox Button Pressed');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      title: Text(
                        'Important',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        print('Important Button Pressed');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        print('Settings Button Pressed');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.white,
                      ),
                      title: Text(
                        'FAQ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        print('FAQ Button Pressed');
                      },
                    ),
                  ],
                ))
          ],
        ));
  }
}
