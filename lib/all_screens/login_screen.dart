import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/all_screens/main_screen.dart';
import 'package:ride_app/all_screens/registration_screen.dart';
import 'package:ride_app/all_widgets/progress_dialog.dart';
import 'package:ride_app/main.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = 'login';

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35),
              Image(
                image: AssetImage('images/logo.png'),
                width: 390,
                height: 250,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1),
              Text(
                'Login as a Rider',
                style: TextStyle(fontSize: 24, fontFamily: 'Brand Bold'),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 1),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 1),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (!emailTextEditingController.text.contains('@')) {
                          displayToastMessage('Email address is not Valid.', context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage('Password is not validy.', context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontFamily: 'Brand Bold', color: Colors.black),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: Colors.white,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text('Do not have Account? Register Here!'),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: "Authenticating, Please wait...",
        );
      },
    );

    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    )
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage('Error:' + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then(
        (DataSnapshot snap) {
          if (snap.value != null) {
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
            displayToastMessage('You are logged-in', context);
          } else {
            Navigator.pop(context);
            _firebaseAuth.signOut();
            displayToastMessage('No record for this user. Please create new account.', context);
          }
        },
      );
    } else {
      Navigator.pop(context);
      displayToastMessage('Error Occored, can not be Signed-in.', context);
    }
  }
}
