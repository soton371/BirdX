import 'package:birdx/screens/contacts/contact_screen.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'BirdX',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          brightness: MediaQuery.of(context).platformBrightness,
          ),
      home: const ContactScreen(),
    );
  }
}
