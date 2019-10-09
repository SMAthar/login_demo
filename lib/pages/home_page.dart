import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_demo/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  String displayName;
  String email;
  String photoUrl;
  bool isLoding = true;
  bool isLoggingOut = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser().then((user){
      Firestore.instance.collection('users').document(user.uid).get().then((DocumentSnapshot ds){
        displayName = ds.data['displayName'];
        email = ds.data['email'];
        photoUrl = ds.data['photoUrl'];
      }).then((val){
        setState(() {
         isLoding = false; 
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          isLoding 
          ? Center(child: CircularProgressIndicator(),)
          : homePageView(),
          isLoggingOut 
          ? Center(child: CircularProgressIndicator())
          : Container()
        ],
      ),
    );
  }

  Widget homePageView(){
    return Container(
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.175,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          child: photoUrl != null
                              ? Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(photoUrl)
                                  )
                                ),
                              )
                              : Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.black,
                              ),
                          radius: 30,
                          backgroundColor: Colors.transparent,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              displayName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 70,
                    child: MaterialButton(
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: () async{
                        setState(() {
                         isLoggingOut = true; 
                        });
                        FirebaseAuth auth = FirebaseAuth.instance;
                        FirebaseUser user = await auth.currentUser();
                        auth.signOut();
                        await auth.fetchSignInMethodsForEmail(email: user.email).then((vals){
                          for (var val in vals) {
                            if(val.contains('google')){
                              GoogleSignIn googleSignIn = GoogleSignIn();
                              googleSignIn.disconnect();
                              googleSignIn.signOut();
                            }
                          }
                        });
                        Navigator.pushNamed(context, '/');
                      },
                      color: Colors.greenAccent[700],
                      shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}