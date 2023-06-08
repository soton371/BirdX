import 'package:flutter/cupertino.dart';

class MyColors {
  static Color emptyText = CupertinoColors.systemGrey;

  static Color segmentedControlText(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return CupertinoColors.white;
    } else {
      return CupertinoColors.black;
    }
  }
  static Color toastBackground(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return CupertinoColors.white;
    } else {
      return CupertinoColors.black;
    }
  }
  static Color toastText(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return CupertinoColors.black;
    } else {
      return CupertinoColors.white;
    }
  }
}