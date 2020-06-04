import 'package:flutter/material.dart';
import 'Custom_buttons/Choose_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Chat.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    try {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chat(
        user: user,
      ),
    ),
    );} catch (e){print("Error $e");}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        backgroundColor: Colors.grey[700],
        centerTitle: true,
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
          CustomButton(text_button: "Log In",
              call_back: () async {
            await loginUser();
              })
        ],
      ),
    );
  }
}
