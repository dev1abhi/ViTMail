import 'package:email_formatter_poc/sidenavbar.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';

import 'email_detail_screen.dart';
import 'email_sorting.dart';
import 'models/emaildata.dart';

class EmailScreen extends StatefulWidget {
  final List<EmailData> emails;
  final String displayName;

  const EmailScreen({required this.emails, required this.displayName});

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  List<EmailData> filteredEmails = [];
  int numberOfEmailsToShowInitially = 50; // Display 50 emails initially

  @override
  void initState() {
    super.initState();
    filteredEmails = widget.emails;
  }

  void sortEmails(String category) {
    setState(() {
      //filteredEmails = filteredList;
      filteredEmails = EmailSorting.sortEmails(widget.emails, category);
    });
  }

  void loadMoreEmails() {
    setState(() {
      numberOfEmailsToShowInitially +=
          10; // Increase the number of emails to display
      filteredEmails =
          widget.emails.take(numberOfEmailsToShowInitially).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeightPercentage = 0.09;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        primary: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * appBarHeightPercentage),
          child: Container(
              width: double.maxFinite,
              height: screenHeight * appBarHeightPercentage,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                color: Color(0xFF4F709C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      print('SideNavBar Button Pressed');
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: Text(
                      'Mailbox',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ], //children
              )),
        ),
      ),
      drawer: SideNavBar(userName: widget.displayName),
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              FilterChip(
                label: const Text('Academics'),
                onSelected: (selected) => sortEmails('academics'),
              ),
              FilterChip(
                label: const Text('Hostel'),
                onSelected: (selected) => sortEmails('hostel'),
              ),
              FilterChip(
                label: const Text('Career'),
                onSelected: (selected) => sortEmails('career'),
              ),
              FilterChip(
                label: const Text('Events'),
                onSelected: (selected) => sortEmails('events'),
              ),
              FilterChip(
                label: const Text('Misc'),
                onSelected: (selected) => sortEmails('misc'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmails.length +
                  1, //+1 for the load more emails button
              itemBuilder: (context, index) {
                if (index < filteredEmails.length) {
                  final email = filteredEmails[index];
                  final senderWithoutPattern =
                      email.sender.replaceAll(RegExp(r'<[^>]*>'), '');

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
                      minVerticalPadding: 11,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'From: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: email.sender)
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors
                                .grey, // Choose the color you want for the divider
                            thickness:
                                1.0, // Choose the thickness you want for the divider
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return Center(
                    child: ElevatedButton(
                      onPressed: loadMoreEmails,
                      child: Text(
                        'Load More',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
