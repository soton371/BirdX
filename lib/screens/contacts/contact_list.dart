import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/contact.dart';
import 'package:birdx/utilities/contact_crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key, required this.contacts});
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) => CupertinoContextMenu(
              previewBuilder: (context, animation, child) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SizedBox(
                    height: 60,
                    child: CupertinoListTile(
                      leadingSize: 60,
                      leadingToTitle: 8,
                      padding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        radius: 23,
                      ),
                      title: Text(
                        contacts[index].name,
                        style: TextStyle(
                            fontSize: MyFonts.contactTitleSize,
                            fontWeight: MyFonts.contactTitleWeight),
                      ),
                      subtitle: Text(contacts[index].number),
                    ),
                  ),
                );
              },
              actions: [
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  trailingIcon: CupertinoIcons.pencil,
                  child: const Text("Update"),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    deleteContact(contacts[index]);
                    Navigator.of(context).pop();
                  },
                  isDestructiveAction: true,
                  trailingIcon: CupertinoIcons.delete,
                  child: const Text("Delete"),
                )
              ],
              child: CupertinoListTile(
                leadingSize: 60,
                leadingToTitle: 8,
                padding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 23,
                ),
                title: Text(
                  contacts[index].name,
                  style: TextStyle(
                      fontSize: MyFonts.contactTitleSize,
                      fontWeight: MyFonts.contactTitleWeight),
                ),
                subtitle: Text(contacts[index].number),
              ),
            )
        // CupertinoListTile(
        //   leadingSize: 60,
        //   leadingToTitle: 8,
        //   padding: EdgeInsets.zero,
        //   leading: const CircleAvatar(
        //     backgroundImage: AssetImage('assets/images/avatar.png'),
        //     radius: 23,
        //   ),
        //   title: Text(contacts[index].name,
        //     style: TextStyle(fontSize: MyFonts.contactTitleSize, fontWeight: MyFonts.contactTitleWeight),
        //   ),
        //   subtitle: Text(contacts[index].number),
        // ),
        );
  }
}
