import 'package:birdx/screens/contacts/contact_empty.dart';
import 'package:birdx/screens/contacts/contact_list.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/widgets/add_contact_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: 2!=2? const ContactEmpty() :
      NestedScrollView(
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
                onPressed: ()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>const SummaryScreen()))),
          ),
        ],
        body: const ContactList(),
      ),
    );
  }
}