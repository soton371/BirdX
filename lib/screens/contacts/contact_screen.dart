import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_sizes.dart';
import 'package:birdx/models/contact.dart';
import 'package:birdx/screens/contacts/contact_list.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/utilities/contact_crud.dart';
import 'package:flutter/cupertino.dart';

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
                  Text("There are no any\ncontacts saved yet\n\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MyColors.emptyText)),
                  CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Add Contacts"),
                      onPressed: () => addContactDialog(context))
                ],
              ),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, scrollIs) => [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text("Contacts"),
                  trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.add),
                      onPressed: () {}),
                  leading: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text("Summary"),
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const SummaryScreen()))),
                ),
              ],
              body: ContactList(
                contacts: contacts,
              ),
            ),
    );
  }

  //all function
  void addContactDialog(BuildContext context) {
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
                    addContact(name: name, number: number).then((value) {
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
