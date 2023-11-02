import 'package:flutter/material.dart';

class EmailScreen extends StatelessWidget {
  final List<EmailData> emails;

  EmailScreen({required this.emails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emails'),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          return ListTile(
            title: Text('From: '+email.sender),
            minVerticalPadding: 5,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email.subject),
                Text(email.body),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmailData {
  final String sender;
  final String subject;
  final String body;

  EmailData({required this.sender, required this.subject, required this.body});
}
