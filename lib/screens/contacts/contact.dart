import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context,scrollIs)=>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text("Contacts"),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.add), 
              onPressed: (){}
              ),
              leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text("Summary"), 
              onPressed: (){}
              ),
          ),
        ], 
        body: const SizedBox()
        ),
    );
  }
}
