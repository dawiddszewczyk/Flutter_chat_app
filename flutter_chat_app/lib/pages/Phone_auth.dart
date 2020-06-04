import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Authservice.dart';
class sms_auth extends StatefulWidget {
  @override
  _sms_authState createState() => _sms_authState();
}

class _sms_authState extends State<sms_auth> {
  final formKey = new GlobalKey<FormState>();

  String phoneNumber,verificationId,smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.grey[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 25.0,right: 25.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: 'Enter phone number'),
                  onChanged: ((val){
                    this.phoneNumber =val;
                  }),
                ),
            ),
            codeSent ? Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter your Code'),
                onChanged: (val){
                  setState(() {
                    this.smsCode = val;
                  });
                },
              ),
            ): Container(),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: RaisedButton(
                    child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                    onPressed: () {
                      codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNumber);
                    })),
          ],
        ),
      ),
    );
  }
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
