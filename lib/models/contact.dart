import 'package:birdx/database/database_helper.dart';

class Contact {
  int? id;
  String image;
  String name;
  String number;

  Contact({this.id, required this.image, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnNumber: number,
    };
  }
}