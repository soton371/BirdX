import 'package:birdx/database/database_helper.dart';

class Contact {
  int? id;
  String name;
  String number;

  Contact({this.id, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnNumber: number,
    };
  }
}