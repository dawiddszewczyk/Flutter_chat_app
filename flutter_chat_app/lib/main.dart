
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/p__MainScreenChatRooms.dart';
import 'package:flutter_chat_app/pages/helper/f__ShareUserInfo.dart';
import 'pages/p__StartScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState(){
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userIsLoggedIn ? Choose() : Chatrooms(),
    );
  }
}
