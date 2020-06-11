import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/constants.dart';
import 'package:todos/screens/home/home_page.dart';

class AuthService {

  static AuthService instance = AuthService._();

  AuthService._();


  /// verfication of the Phone number
  Future<void> verifyPhone(BuildContext context, String phone) async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) async {
      try {
        Navigator.pop(context);
        AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        FirebaseUser user = authResult.user;
        if (user != null) {
          print("Phone verfication Complete ! you can navigate to home screen");
          Navigator.pushNamed(context, HomePage.id);
        }
      } catch (e) {
        print(e.toString());
      }
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print("Failed Verifcation");
      debugPrint(authException.message);
    };

    final PhoneCodeSent smsOTPSent = (String verificationId, [int forceResendingToken]) {
      smsOTPDialog(context, verificationId);
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verificationId) {
      print("Time out");
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  /// open this Alert dialog to verify OTP CODE
  smsOTPDialog(BuildContext context, String verificationId) {
    TextEditingController _controller = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          title: Text("Enter SMS Code"),
          contentPadding: const EdgeInsets.all(10.0),
          content: Container(
            height: 80.0,
            child: Column(
              children: <Widget>[
                TextFormField(controller: _controller),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                try {
                  final String code = _controller.text.trim();
                  AuthCredential credential = PhoneAuthProvider.getCredential(
                    verificationId: verificationId,
                    smsCode: code,
                  );
                  AuthResult authResult =
                      await FirebaseAuth.instance.signInWithCredential(credential);
                  FirebaseUser user = authResult.user;
                  if (user != null) {
                    print("Phone verfication Complete ! you can navigate to home screen");
                    Navigator.pushNamed(context, HomePage.id);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text("Done"),
              color: Colors.white,
              textColor: greenColor,
            ),
          ],
        );
      },
    );
  }

  ///logout from the App
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  ///get current userID
  Future<String> getUserId() async {
    String id = '';
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      id = user.uid;
    }
    return id;
  }
}
