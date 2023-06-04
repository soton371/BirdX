import 'package:birdx/configs/my_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 20,
          itemBuilder: (context, index) => CupertinoListTile(
            leadingSize: 60,
            leadingToTitle: 8,
            padding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              radius: 23,
            ),
            title: Text(
              'Alex Smith',
              style: TextStyle(fontSize: MyFonts.contactTitleSize, fontWeight: MyFonts.contactTitleWeight),
            ),
            subtitle: Text('01234567890$index'),
          ),
        );
  }
}