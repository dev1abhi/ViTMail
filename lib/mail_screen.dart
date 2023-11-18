
import 'package:flutter/material.dart';

import 'email_detail_screen.dart';
import 'models/emaildata.dart';

class EmailScreen extends StatelessWidget {
  final List<EmailData> emails;

  EmailScreen({required this.emails});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeightPercentage = 0.09;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        primary: true,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * appBarHeightPercentage),
          child: Container(
            width: double.infinity,
            height: screenHeight * appBarHeightPercentage,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFF4F709C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Mailbox',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),



      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];


          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailDetailScreen(email: email),
                ),
              );
            },
            child: ListTile(
              title: Text(
                email.subject,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              minVerticalPadding: 5,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'From: ',style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: email.sender)
                      ]
                    ),
                  ),

                  Divider(
                    color: Colors.grey, // Choose the color you want for the divider
                    thickness: 1.0, // Choose the thickness you want for the divider
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


