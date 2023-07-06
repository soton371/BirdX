import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

myToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
