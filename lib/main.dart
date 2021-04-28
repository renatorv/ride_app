import 'package:flutter/material.dart';
import 'package:ride_app/all_screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Rider App',
      theme: ThemeData(
        fontFamily: 'Brand Bold',
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
