import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/Google_Logo.svg",
          width: 25,
          height: 25,
        ),
        SizedBox(width: 20),
        Text("Sign in with Google"),
      ],
    );
  }
}
