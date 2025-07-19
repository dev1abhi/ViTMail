import 'package:flutter/material.dart';

class SideNavBar extends StatefulWidget {
  final String userName;

  const SideNavBar({super.key, required this.userName});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {

    final firstName = widget.userName.split(' ')[0];

    return Drawer(
        width: 240,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(74),
            bottomRight: Radius.circular(74),
          ),
        ),
        backgroundColor: const Color(0xFF213555),
        child: Stack(
          children: [
            const Positioned(
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
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 261),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: const Text(
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
                      leading: const Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      title: const Text(
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
                      leading: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      title: const Text(
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
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: const Text(
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
                      leading: const Icon(
                        Icons.question_mark_rounded,
                        color: Colors.white,
                      ),
                      title: const Text(
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
