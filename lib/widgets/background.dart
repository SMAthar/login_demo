import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blueGrey[50],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child:Stack(
                children: <Widget>[
                  Positioned(
                    top: -(MediaQuery.of(context).size.width * 0.85) * 0.5,
                    right: -(MediaQuery.of(context).size.width * 0.85) * 0.5,
                    child: ClipOval(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.85 ,
                        width: MediaQuery.of(context).size.width * 0.85,
                        color: Colors.greenAccent[100],
                      ),
                    ),
                  ),
                  ClipPath(
                    child: Container(
                      color: Colors.greenAccent[400],
                    ),
                    clipper: MyClipper(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {

    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.6, 0);
    path.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.10,
      size.width * 0.80,
      size.height * 0.21
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.38,
      size.width,
      size.height * 0.40
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
