import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/f__AuthService.dart';
import 'Custom_buttons/b__Buttons.dart';
import 'p__LoginScreen.dart';
import 'p__RegisterScreen.dart';
import 'p__PhoneAuthScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Choose extends StatefulWidget {

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat app',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('images/choose.png'),
              ),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 35,
                  color: const Color(0xff17aff5),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
                SizedBox(height: 40),
                CustomButton(
                  textbutton: "Log In",
                  callback: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                         Login())
                    );
                  },
                ),
                SizedBox(height: 30),
                CustomButton(
                textbutton: "Register",
                callback: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                          Register())
                  );
                },
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                            AuthService().handleAuth())
                    );
                  },child: Text("Phone authorization")),
                )
            ],
          ),
        ),
      ),
    );
  }
}