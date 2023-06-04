import 'package:flutter/cupertino.dart';

class MyColors {
  static Color segmentedControlText(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return CupertinoColors.white;
    } else {
      return CupertinoColors.black;
    }
  }
}