import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool inputValidation({required String name, required String number}) {
  if (name.isEmpty && number.isEmpty) {
    myToast(msg: "Please give name and number");
    return false;
  }
  if (name.isEmpty) {
    myToast(msg: "Please give the name");
    return false;
  }
  if (number.isEmpty) {
    myToast(msg: "Please give the number");
    return false;
  }
  if (number.isNotEmpty && number.length != 11) {
    myToast(msg: "Please give the 11 digits number");
    return false;
  }
  return true;
}

myToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
