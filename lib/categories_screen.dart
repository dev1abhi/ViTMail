// ignore_for_file: must_be_immutable

import 'package:email_formatter_poc/mail_screen.dart';
import 'package:email_formatter_poc/models/emaildata.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  final List<EmailData> emailList;

  CategoriesScreen({required this.emailList});




  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<EmailData> academicEmails = [];
  List<EmailData> hostelEmails = [];
  List<EmailData> careerEmails = [];
  List<EmailData> eventsEmails = [];
  List<EmailData> miscEmails = [];

  void sortEmails(String para){
    print('Total emails: ${widget.emailList!.length}');  // Debug print statement
    switch (para){
      case 'academics': {
        widget.emailList!.where((email) =>
        email.sender.contains('HOD') ||
        email.sender.contains('Dean')).forEach((email) {
          //print('Adding academic email: ${email.subject}');  // Debug print statement
          academicEmails.add(email);
        });
        //print('Total academic emails: ${academicEmails.length}');  // Debug print statement
      }
      case 'hostel': {
        widget.emailList!.where((email) =>
        email.sender.contains('Hostel') ||
        email.sender.contains('Warden')).forEach((email) {
          hostelEmails.add(email);
        });
      }
      case 'career': {
        widget.emailList!.where((email) =>
        email.sender.contains('VITTBI') ||
        email.sender.contains('Placement') ||
        email.sender.contains('IR')).forEach((email) {
          careerEmails.add(email);
        });
      }
      case 'events': {
        widget.emailList!.where((email) =>
        email.sender.contains('Student Welfare') ||
        email.sender.contains('Riviera') ||
        email.subject.toLowerCase().contains('riviera') ||
        email.sender.contains('Gravitas') ||
        email.subject.toLowerCase().contains('gravitas')).forEach((email) {
          eventsEmails.add(email);
        });
      }
      case 'misc': {
        widget.emailList!.where((email) =>
        email.sender.contains('Viswanathan') ||
        email.sender.contains('PROVC') ||
        email.sender.contains('Chancellor') ||
        email.sender.contains('Vice Chancellor') ||
        email.sender.contains('Periyar') ||
        email.sender.contains('Duolingo') ||
        email.sender.contains('Google') ||
        email.subject.toLowerCase().contains('greetings') ||
        email.body.toLowerCase().contains('quiz') ||
        email.subject.toLowerCase().contains('quiz') ||
        email.body.toLowerCase().contains('notes') ||
        email.subject.toLowerCase().contains('notes')).forEach((email) {
          miscEmails.add(email);
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
    body: Container(
  width: screenSize.width,
  height: screenSize.height,
  clipBehavior: Clip.antiAlias,
  decoration: ShapeDecoration(
    color: Color(0xFFF5EFE7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Stack(
    children: [
      Positioned(
        left: 28,
        top: 17,
        child: Container(
          width: 304,
          height: 766,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFF213555)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
      Positioned(
        left: 73,
        top: 121,
        child: Container(
          width: 211,
          height: 240,
          decoration: ShapeDecoration(
            color: Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
      Positioned(
        left: 282,
        top: 16,
        child: Container(
          width: 50,
          height: 50,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF053B50),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 7,
                top: 6,
                child: Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/37x37"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: -80.59,
        top: 1.19,
        child: Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.63),
          child: Container(
            width: 211.94,
            height: 143,
            decoration: BoxDecoration(color: Color(0xFF213555)),
          ),
        ),
      ),
      Positioned(
        left: 84,
        top: 516,
        child: Container(
          width: 44,
          height: 40.42,
          child: ElevatedButton(onPressed: (){
            sortEmails('hostel');
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailScreen(emails: hostelEmails)));
          },
          child: Text('Hostel logo')),
        ),
      ),
      Positioned(
        left: 211,
        top: 516,
        child: Container(
          width: 47,
          height: 47,
          child: ElevatedButton(onPressed: (){
            sortEmails('career');
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailScreen(emails: careerEmails)));
          }, child: Text('Career logo')),
        ),
      ),
      Positioned(
        left: 157,
        top: 395,
        child: Container(
          width: 40,
          height: 49.14,
          child: ElevatedButton(onPressed: (){
            sortEmails('academics');
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailScreen(emails: academicEmails)));
          },
          child: Text('Academics logo'))
        ),
      ),
      Positioned(
        left: 77,
        top: 633,
        child: Container(
          width: 54,
          height: 54,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: ElevatedButton(onPressed: (){
            sortEmails('events');
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailScreen(emails: eventsEmails)));
          }, child: Text('Events logo')),
        ),
      ),
      Positioned(
        left: 196,
        top: 643,
        child: Container(
          width: 62,
          height: 33.6,
          child: ElevatedButton(onPressed: (){
            sortEmails('misc');
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailScreen(emails: miscEmails)));
          }, child: Text('Miscellaneous logo')),
        ),
      ),
      Positioned(
        left: 98,
        top: 229,
        child: SizedBox(
          width: 108,
          height: 37,
          child: Text(
            'Subject',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
      Positioned(
        left: 98,
        top: 306,
        child: SizedBox(
          width: 116,
          height: 32,
          child: Text(
            'Sender name',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
        ),
      ),
      Positioned(
        left: 111,
        top: 148,
        child: Container(
          width: 137.60,
          height: 48,
          decoration: ShapeDecoration(
            color: Color(0xFF213555),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
        ),
      ),
      Positioned(
        left: 141,
        top: 158,
        child: SizedBox(
          width: 88,
          height: 25,
          child: Text(
            'Category',
            style: TextStyle(
              color: Color(0xFFF5EFE7),
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
      Positioned(
        left: 68,
        top: 571,
        child: Container(
          padding: const EdgeInsets.only(top: 4, left: 13),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 86,
                height: 23,
                child: Text(
                  'HOSTEL',
                  style: TextStyle(
                    color: Color(0xFF213555),
                    fontSize: 15,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 121,
        top: 458,
        child: Container(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 7, bottom: 1),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 23,
                child: Text(
                  'ACADEMICS',
                  style: TextStyle(
                    color: Color(0xFF213555),
                    fontSize: 15,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 56,
        top: 694,
        child: Container(
          padding: const EdgeInsets.only(top: 5, left: 12, bottom: 2),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 23,
                child: Text(
                  'EVENTS',
                  style: TextStyle(
                    color: Color(0xFF213555),
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 154,
        top: 694,
        child: Container(
          height: 30,
          padding: const EdgeInsets.only(top: 5, left: 9, bottom: 5),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 44,
                height: 20,
                child: Text(
                  'MISC.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 192,
        top: 571,
        child: Container(
          width: 87,
          height: 33,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 82,
                  height: 27,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
              ),
              Positioned(
                left: 10,
                top: 2,
                child: SizedBox(
                  width: 77,
                  height: 31,
                  child: Text(
                    'CAREER',
                    style: TextStyle(
                      color: Color(0xFF213555),
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 269,
        top: 726,
        child: Container(
          width: 177,
          height: 177,
          decoration: ShapeDecoration(
            color: Color(0xFF4F709C),
            shape: OvalBorder(),
          ),
        ),
      ),
    ],
  ),
)
    );
  }
}
