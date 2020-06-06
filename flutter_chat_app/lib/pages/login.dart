import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/ChatRoom.dart';
import 'package:flutter_chat_app/pages/helper/helperfun.dart';
import 'package:flutter_chat_app/pages/services/database.dart';
import 'Custom_buttons/Choose_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Chat.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController userNameText_E_C = new TextEditingController();
  TextEditingController emailNameText_E_C = new TextEditingController();
  String email;
  String password;
  QuerySnapshot snapshotUserInfo;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Future<void> loginUser() async {
    try {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    databaseMethods.getUserByUserEmail(emailNameText_E_C.text).then((val) async{
      QuerySnapshot snapshotUserInfo = await DatabaseMethods().getUserInfo(emailNameText_E_C.text);
      HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data['name']);
    });
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chatrooms(),
    ),
    );} catch (e){print("Error $e");}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            validator: (val){
              return val.isEmpty || val.length<2 ? "Invalid adres email": null;
            },
             controller: emailNameText_E_C,
            onChanged: (value) => email = value,
            keyboardType:  TextInputType.emailAddress,
            decoration:  InputDecoration(
              hintText: "Insert your Email...",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:  BorderSide(color: Colors.white, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: BorderSide(color: Colors.white)),
              filled: true,
            ),

          ),
          SizedBox(height: 40),
          TextField(
            controller: userNameText_E_C,
            onChanged: (value) => password = value,
            autocorrect: false,
            obscureText: true,
            decoration:  InputDecoration(
              hintText: "Insert your Password...",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:  BorderSide(color: Colors.white, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: BorderSide(color: Colors.white)),
              filled: true,
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
