import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/configs/my_sizes.dart';
import 'package:birdx/models/contact.dart';
import 'package:birdx/screens/message/message_scr.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/utilities/contact_crud.dart';
import 'package:birdx/utilities/my_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contacts = [];
  @override
  void initState() {
    super.initState();
    getContacts().then((value) {
      setState(() {
        contacts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/phone_book.png",
                    height: MySizes.emptyIcon,
                    width: MySizes.emptyIcon,
                  ),
                  Text("There are no any\nrecipients saved yet\n\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MyColors.emptyText)),
                  CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Add Recipient"),
                      onPressed: () => addContactDialog())
                ],
              ),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, scrollIs) => [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text("Contacts"),
                  trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: addContactDialog,
                      child: const Icon(CupertinoIcons.add)),
                  leading: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text("Summary"),
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const SummaryScreen()))),
                ),
              ],
              body: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: contacts.length,
                itemBuilder: (context, index) => CupertinoContextMenu(
                  previewBuilder: (context, animation, child) {
                    return SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              radius: 23,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contacts[index].name,
                                  style: TextStyle(
                                      fontSize: MyFonts.contactTitleSize,
                                      fontWeight: MyFonts.contactTitleWeight),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  contacts[index].number,
                                  style: TextStyle(color: MyColors.emptyText),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  actions: [
                    CupertinoContextMenuAction(
                      onPressed: () {
                        Navigator.pop(context);
                        updateContactDialog(contacts[index]);
                      },
                      trailingIcon: CupertinoIcons.pen,
                      child: const Text("Update"),
                    ),
                    CupertinoContextMenuAction(
                      onPressed: () {
                        deleteContact(contacts[index]).then((value) {
                          getContacts().then((value) {
                            Navigator.pop(context);
                            setState(() {
                              contacts = value;
                            });
                          });
                        });
                      },
                      isDestructiveAction: true,
                      trailingIcon: CupertinoIcons.delete,
                      child: const Text("Delete"),
                    )
                  ],
                  child: CupertinoListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) =>
                                  MessageScreen(name: contacts[index].name,number: contacts[index].number,)));
                    },
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
              ),
            ),
    );
  }

  //all function
  void addContactDialog() {
    String name = '';
    String number = '';
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Add New Contact"),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      placeholder: "Enter name",
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      placeholder: "Enter number",
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        number = value;
                      },
                    )
                  ],
                );
              }),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  isDestructiveAction: true,
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  child: const Text('Save'),
                  onPressed: () {
                    if (name.trim().isEmpty || name.trim().length <3) {
                      myToast(msg: 'Please enter valid name');
                      return;
                    }
                    if (number.trim().isEmpty || number.trim().length>14 || number.trim().length<10) {
                      myToast(msg: 'Please enter valid number');
                      return;
                    }
                    addContact(name: name, number: number).then((value1) {
                      getContacts().then((value) {
                        setState(() {
                          contacts = value;
                        });
                        Navigator.pop(context);
                      });
                    });
                  },
                )
              ],
            ));
  }

  void updateContactDialog(Contact contact) {
    TextEditingController nameController =
        TextEditingController(text: contact.name);
    TextEditingController numberController =
        TextEditingController(text: contact.number);
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Update Recipient"),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      keyboardType: TextInputType.number,
                      controller: numberController,
                    )
                  ],
                );
              }),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  isDestructiveAction: true,
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  child: const Text('Update'),
                  onPressed: () {
                    updateContact(
                            contact: contact,
                            newName: nameController.text,
                            newNumber: numberController.text)
                        .then((value1) {
                      getContacts().then((value) {
                        setState(() {
                          contacts = value;
                        });
                        Navigator.pop(context);
                      });
                    });
                  },
                )
              ],
            ));
  }
}
