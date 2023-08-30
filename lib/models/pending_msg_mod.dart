import 'package:birdx/database/database_helper.dart';

class PendingMsgModel {
  int? id;
  String name;
  String number;
  String message;
  String durationInSec;
  String time;
  String statusIs;  //statusIs = 0 means pending statusIs = 1 means sent
  String dateTime;

  PendingMsgModel({this.id, required this.name, required this.number, required this.message, required this.durationInSec, required this.time, required this.statusIs, required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.pendingColumnName: name,
      DatabaseHelper.pendingColumnNumber: number,
      DatabaseHelper.pendingColumnMessage: message,
      DatabaseHelper.pendingColumnDurationInSec: durationInSec,
      DatabaseHelper.pendingColumnTime: time,
      DatabaseHelper.pendingColumnStatusIs: statusIs,
      DatabaseHelper.pendingColumnDateTime: dateTime,
    };
  }
}