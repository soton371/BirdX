import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key,required this.contacts});
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) => CupertinoListTile(
            leadingSize: 60,
            leadingToTitle: 8,
            padding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              radius: 23,
            ),
            title: Text(contacts[index].name,
              style: TextStyle(fontSize: MyFonts.contactTitleSize, fontWeight: MyFonts.contactTitleWeight),
            ),
            subtitle: Text(contacts[index].number),
          ),
        );
  }
}