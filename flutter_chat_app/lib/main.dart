
import 'package:flutter/material.dart';
import 'pages/Home_choose.dart';
import 'pages/Loading.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/Chat.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Choose(),
    );
  }
}

