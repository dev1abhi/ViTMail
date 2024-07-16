import 'package:flutter/material.dart';
import 'package:email_formatter_poc/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Sign In + googleapis',
      home: SignInDemo(),
    ),
  );
}
