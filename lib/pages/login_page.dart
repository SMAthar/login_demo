import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  bool _obscureText = true;
  IconData _icon = Icons.visibility_off;
  Color _color = Colors.grey;
  String _email,_password;
  bool isLogging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          loginView(),
          isLogging
          ? Center(child: CircularProgressIndicator(),)
          : Container()
        ],
      ),
    );
  }


  Widget loginView(){
    return ListView(
      children: <Widget>[
        SizedBox(height: 140,),
        Center(
          child: CircleAvatar(
            child: FlutterLogo(size: 70,),
            radius: 30,
            backgroundColor: Colors.transparent,
          )
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            color: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide.none
                ),
                prefixIcon: Icon(Icons.email, color: Colors.black,),
                hintText: 'Someone@something.com',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val){
                _email = val;
              },
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            color: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide.none
                ),
                prefixIcon: Icon(Icons.lock ,color: Colors.black,),
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(_icon, color: _color,),
                  onPressed: (){
                    setState(() {
                     _obscureText = !_obscureText;
                     if(_obscureText){
                       _icon = Icons.visibility_off;
                       _color = Colors.grey;
                     }else{
                       _icon = Icons.visibility;
                       _color = Colors.black;
                     } 
                    });
                  },
                ),
              ),
              onChanged: (val){
                _password = val;
              },
              obscureText: _obscureText,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (){},
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                  letterSpacing: 1.1,
                  color: Colors.grey
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 40.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'SIGN IN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                   isLogging = true; 
                  });
                  FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                      email: _email,
                      password: _password
                    ).then((user){
                      Navigator.of(context).pushReplacementNamed('/homePage');
                    });
                },
                child: Container(
                  child: Icon(Icons.arrow_forward, color: Colors.white,),
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.green[700],
                        Colors.greenAccent
                      ]
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 175,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't have an account ? ",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed('/signUpPage');
                },
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent[400]
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}