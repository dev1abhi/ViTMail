import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
            title: Text('From: ' + email.sender),
            minVerticalPadding: 5,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email.subject),
                //if (email.body != null && !email.body.contains("!DOCTYPE html") ) Text(email.body),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailDetailScreen(email: email),
                      ),
                    );
                  },
                  child: Text('View HTML'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmailDetailScreen extends StatelessWidget {
  final EmailData email;

  EmailDetailScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ' + email.sender),
            Text(email.subject),
            if (email.body != null && !email.body.contains("!DOCTYPE html") ) Text(email.body)
            else HtmlWidget(email.body),

            if (email.html != null) HtmlWidget(email.html),
          ],
        ),
      ),
    );
  }
}

class EmailData {
  final String sender;
  final String subject;
  final String body;
  final String html;

  EmailData({
    required this.sender,
    required this.subject,
    required this.body,
    required this.html,
  });
}
