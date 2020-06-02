import 'package:flutter/material.dart';
import 'Custom_buttons/Choose_buttons.dart';
class Choose extends StatefulWidget {
  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat app',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Text("Simple Chat",
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30)),
                SizedBox(height: 30),
                CustomButton(
                  text_button: "Log In",
                  call_back: () {},
                ),
                SizedBox(height: 30),
                CustomButton(
                text_button: "Register",
                call_back: () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}
