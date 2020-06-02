import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/Custom_buttons/Choose_buttons.dart';
import 'Chat.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chat(),
      ),
    );
  }
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
            await registerUser();
              })
        ],
      ),
    );
  }
}
