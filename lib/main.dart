import 'package:birdx/screens/contacts/contact_screen.dart';
import 'package:birdx/services/my_notification_services.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MyNotificationServices().initializeNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Parrot',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          brightness: Brightness.light,
          ),
      home: ContactScreen(),
    );
  }
}
