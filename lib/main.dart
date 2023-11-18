import 'package:flutter/material.dart';
import 'package:email_formatter_poc/api.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Sign In + googleapis',
      home: SignInDemo(),
    ),
  );
}
