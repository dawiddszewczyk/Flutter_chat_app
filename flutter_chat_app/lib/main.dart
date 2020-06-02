
import 'package:flutter/material.dart';
import 'pages/Home_choose.dart';
import 'pages/Loading.dart';
import 'pages/login.dart';
import 'pages/register.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/choose',
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/choose': (context) => Choose(),
        '/loading': (context) => Loading(),
      },
    );
  }
}

