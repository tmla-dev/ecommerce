import 'package:ecommerce/views/signin_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF6962E7),
        accentColor: const Color(0xFFA9A6EA),
        backgroundColor: Color(0xFFF1EFF6),
      ),
      home: SigninPage(),
    );
  }
}

