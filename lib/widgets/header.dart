import 'package:e_commerce/theme/preset_styles.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final String name;

  const MainHeader({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Text(
        name,
        style: headerTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
    );
  }
}
