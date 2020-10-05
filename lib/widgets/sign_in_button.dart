import 'package:e_commerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatefulWidget {
  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.green,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              provider.isNewUser ? "Sign Up" : "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
