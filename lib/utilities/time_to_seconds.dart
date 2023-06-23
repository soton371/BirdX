int timeToSeconds(String time) {
  List<String> parts = time.split(':');

  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  double parseValue = double.parse(parts[2]);
  int seconds = int.parse(parseValue.toInt().toString());

  int totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

  return totalSeconds;
}
