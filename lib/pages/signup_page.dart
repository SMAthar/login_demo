import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_demo/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  bool _obscureText = true;
  IconData _icon = Icons.visibility_off;
  Color _color = Colors.grey;
  String _firstName,_lastName, _email, _password,_fullName;
  bool isSigning = false;

  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          signupView(),
          isSigning
          ? Center(child: CircularProgressIndicator(),)
          : Container()
        ],
      ),
    );
  }


  Widget signupView(){
    return ListView(
      children: <Widget>[
        SizedBox(height: 130,),
        Center(
          child: Text(
            "Create account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          ),
        ),
        SizedBox(height: 30,),
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
                prefixIcon: Icon(Icons.person, color: Colors.black,),
                hintText: 'First Name',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val){
                _firstName = val;
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
                prefixIcon: Icon(Icons.person, color: Colors.black,),
                hintText: 'Last Name',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val){
                _lastName = val;
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
                prefixIcon: Icon(Icons.email, color: Colors.black,),
                hintText: 'Someone@something.com',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val){
                _email = val;
              },
              keyboardType: TextInputType.emailAddress,
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
              obscureText: _obscureText,
              onChanged: (val){
                _password = val;
              },
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        SizedBox(height: 50.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                   isSigning = true; 
                  });
                  _fullName = _firstName +' '+ _lastName;
                  FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                    email: _email,
                    password: _password
                  ).then((user){
                    Firestore.instance
                    .collection('/users')
                    .document(user.user.uid)
                    .setData({
                      'email':user.user.email,
                      'uid': user.user.uid,
                      'displayName':_fullName,
                      'photoUrl':user.user.photoUrl
                    });
                  }).then((val){
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
        SizedBox(height: 80,),
        Center(
          child: Text(
            'Or create acccount using social media',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialLoginButton(
                color: Color(0xFFDD4B39),
                iconData: FontAwesomeIcons.googlePlus,
                onTap: (){
                  setState(() {
                   isSigning = true; 
                  });
                  googleSignIn.signIn().then((result){
                    result.authentication.then((googleKey){
                      AuthCredential credential = GoogleAuthProvider.getCredential(
                        idToken: googleKey.idToken,
                        accessToken: googleKey.accessToken
                      );
                      FirebaseAuth.instance.signInWithCredential(credential).then((rslt){
                        Firestore.instance
                          .collection('users')
                          .document(rslt.user.uid)
                          .setData({
                            'email':rslt.user.email,
                            'displayName':rslt.user.displayName,
                            'photoUrl': rslt.user.photoUrl,
                            'uid': rslt.user.uid
                          }).then((val){
                            Navigator.pushReplacementNamed(context, '/homePage');
                          });
                      });
                    });
                  });
                },
              ),
              SizedBox(width: 20,),
              SocialLoginButton(
                color: Color(0xFF3B5998),
                iconData: FontAwesomeIcons.facebook,
                onTap: (){},
              ),
              SizedBox(width: 20,),
              SocialLoginButton(
                color: Color(0xFF1DA1F2),
                iconData: FontAwesomeIcons.twitter,
                onTap: (){},
              ),
            ],
          ),
        )
      ],
    );
  }
}