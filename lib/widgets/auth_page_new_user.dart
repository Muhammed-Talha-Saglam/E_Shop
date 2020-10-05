import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                provider.isNewUser
                    ? "Already have an account? Sign In!"
                    : "Create An Account",
                style: signInTextStyle.copyWith(color: Colors.white),
              ),
            ),
            onTap: provider.toggleisNewUser,
          ),
        ],
      ),
    );
  }
}
