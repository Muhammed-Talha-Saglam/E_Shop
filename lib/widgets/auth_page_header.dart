import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPageheader extends StatefulWidget {
  @override
  _AuthPageheaderState createState() => _AuthPageheaderState();
}

class _AuthPageheaderState extends State<AuthPageheader> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          provider.isNewUser ? "Create An Account" : "Sign In",
          style: headerTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
