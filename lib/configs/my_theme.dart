import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  Color lightPrimaryColor = CupertinoColors.systemBlue;
  Color darkPrimaryColor = CupertinoColors.systemGreen;

  static ThemeData lightTheme = ThemeData(
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
          primary: _myTheme.lightPrimaryColor,),
      useMaterial3: true);

  static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _myTheme.darkPrimaryColor,
      ),
      useMaterial3: true);
}

MyTheme _myTheme = MyTheme();
