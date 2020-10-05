import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// We set default style widgets if they are to be used more than once.
// Also it is easier to manage style, if you want make changes later.

InputDecoration defaultInputDecoration(String iconSrc, String hintText) {
  return InputDecoration(
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    icon: SvgPicture.asset(
      iconSrc,
      height: 35,
      width: 35,
    ),
    hintText: hintText,
  );
}

TextStyle headerTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 35,
);

TextStyle signInTextStyle = TextStyle(
  decoration: TextDecoration.underline,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

TextStyle productsTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
