import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/Custom_buttons/Choose_buttons.dart';
import 'package:flutter_chat_app/pages/helper/helperfun.dart';
import 'Chat.dart';
import 'services/database.dart';
import 'ChatRoom.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController userNameText_E_C = new TextEditingController();
  TextEditingController emailNameText_E_C = new TextEditingController();

  Future<void> registerUser() async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    Map<String,String> userInfoMap = {
      "name" : userNameText_E_C.text,
      "email" : emailNameText_E_C.text
    };
    HelperFunctions.saveUserEmailSharedPreference(emailNameText_E_C.text);
    HelperFunctions.saveUserNameSharedPreference(userNameText_E_C.text);

    databaseMethods.uploadUserInfo(userInfoMap);
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chatrooms(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          TextField(
            controller: userNameText_E_C,
            keyboardType:  TextInputType.emailAddress,
            decoration:  InputDecoration(
              hintText: "Insert your Nick...",
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
          CustomButton(text_button: "Register",
          call_back: () async {
            await registerUser();
              })
        ],
      ),
    );
  }
}
