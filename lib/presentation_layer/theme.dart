import 'package:flutter/material.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
      textTheme: TextTheme(
    titleMedium: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
    bodySmall: TextStyle(color: Colors.black, fontSize: 16),
  ));
}
