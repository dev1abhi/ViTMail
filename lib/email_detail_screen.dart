
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'models/emaildata.dart';

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