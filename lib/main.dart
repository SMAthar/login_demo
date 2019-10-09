import 'package:flutter/material.dart';
import 'package:login_demo/pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/loginPage' : (context) => LoginPage(),
        '/signUpPage' : (context) => SignUpPage(),
        '/homePage' : (context) => HomePage()
      },
      home: Scaffold(
        body: Center(
          child: Container(
            child: LoginPage(),
          ),
        ),
      ),
    );
  }
}