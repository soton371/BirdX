
import 'package:intl/intl.dart';

DateTime stringToDate(String string) {
  final format = DateFormat.MMMEd();
  return format.parse(string);
}

DateTime stringToTime(String string) {
  final format = DateFormat.jm();
  return format.parse(string);
}