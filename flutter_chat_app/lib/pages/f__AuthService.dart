import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'p__DashboardScreen.dart';
import 'p__PhoneAuthScreen.dart';
class AuthService{
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context,snapshot){
        if (snapshot.hasData){
          return DashboardPage();
        }
        else {
          return sms_auth();
        }
      },
    );
  }
  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}