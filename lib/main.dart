import 'package:birdx/screens/contacts/contact.dart';
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
        barBackgroundColor: const CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white, 
          darkColor: CupertinoColors.black,
          )
      ),
      home: const ContactScreen(),
    );
  }
}
