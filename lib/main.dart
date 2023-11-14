import 'package:flutter/material.dart';
import 'package:email_formatter_poc/api.dart';

void main() {
  runApp(
    //i want to turn of the debug banner,give me code
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Sign In + googleapis',
      home: SignInDemo(),
    ),
  );
}
