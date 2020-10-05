import 'package:flutter/material.dart';

class TextFormFieldWrappers extends StatelessWidget {
  final Widget child;

  TextFormFieldWrappers({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(25),
        ),
        child: child,
      ),
    );
  }
}
