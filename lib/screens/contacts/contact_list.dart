import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/contact.dart';
import 'package:birdx/screens/message/message_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key, required this.contacts});
  final List<Contact> contacts;

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: widget.contacts.length,
        itemBuilder: (context, index) => FocusedMenuHolder(
          onPressed: (){},
          menuItems: <FocusedMenuItem>[
            FocusedMenuItem(title: const Text("Update"),trailingIcon: const Icon(CupertinoIcons.pen) ,onPressed: (){}),
            FocusedMenuItem(title: Text("Delete",style: TextStyle(color: MyColors.delete),),trailingIcon: Icon(CupertinoIcons.trash,color: MyColors.delete,) ,onPressed: (){}),
          ],
          child: CupertinoListTile(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => const MessageScreen()));
                },
                leadingSize: 60,
                leadingToTitle: 8,
                padding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 23,
                ),
                title: Text(
                  widget.contacts[index].name,
                  style: TextStyle(
                      fontSize: MyFonts.contactTitleSize,
                      fontWeight: MyFonts.contactTitleWeight),
                ),
                subtitle: Text(widget.contacts[index].number),
              ),
        ));
  }
}
