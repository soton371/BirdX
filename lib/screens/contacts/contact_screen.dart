import 'package:birdx/models/contact.dart';
import 'package:birdx/screens/contacts/contact_empty.dart';
import 'package:birdx/screens/contacts/contact_list.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/utilities/contact_crud.dart';
import 'package:birdx/widgets/add_contact_dialog.dart';
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
      contacts = value;
      debugPrint("contacts len: ${contacts.length}");
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: contacts.isEmpty
          ? const ContactEmpty()
          : NestedScrollView(
              headerSliverBuilder: (context, scrollIs) => [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text("Contacts"),
                  trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.add),
                      onPressed: () => addContactDialog(context)),
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
}
