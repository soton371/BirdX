import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:birdx/configs/my_colors.dart';

void myToast(BuildContext context, {required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      timeInSecForIosWeb: 2,
      textColor: MyColors.toastText(context),
      backgroundColor: MyColors.toastBackground(context));
}
