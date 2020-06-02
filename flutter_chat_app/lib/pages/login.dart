import 'package:flutter/material.dart';
import 'Custom_buttons/Choose_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat app"),
        backgroundColor: Colors.grey[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            onChanged: (value) => email = value,
            keyboardType:  TextInputType.emailAddress,
            decoration:  InputDecoration(
              hintText: "Insert your Email...",
            ),
          ),
          SizedBox(height: 40),
          TextField(
            onChanged: (value) => password = value,
            autocorrect: false,
            obscureText: true,
            decoration:  InputDecoration(
              hintText: "Insert your Password...",
            ),),
          SizedBox(height: 40),
          CustomButton(text_button: "Register",
              call_back: () async {
              })
        ],
      ),
    );
  }
}
