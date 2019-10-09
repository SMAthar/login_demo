import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  SocialLoginButton({this.iconData, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          height: 45,
          width: 45,
          child: Icon(
            iconData,
            color: color,
            size: 45.0,
          ),
        ),
      ),
    );
  }
}