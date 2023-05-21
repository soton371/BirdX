import 'package:flutter/cupertino.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Contacts'),
      ),
      child: Center(
        child: Text('data'),
      )
      );
  }
}