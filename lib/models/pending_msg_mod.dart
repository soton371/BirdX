import 'package:birdx/database/database_helper.dart';

class PendingMsgModel {
  int? id;
  String name;
  String number;
  String message;
  String durationInSec;
  String time;

  PendingMsgModel({this.id, required this.name, required this.number, required this.message, required this.durationInSec, required this.time});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.pendingColumnName: name,
      DatabaseHelper.pendingColumnNumber: number,
      DatabaseHelper.pendingColumnMessage: message,
      DatabaseHelper.pendingColumnDurationInSec: durationInSec,
      DatabaseHelper.pendingColumnTime: time,
    };
  }
}