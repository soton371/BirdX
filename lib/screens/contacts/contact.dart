import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Summary'),
          onPressed: () {
            // Add button pressed
            // Perform the desired action here
          },
        ),
        middle: const Text('Contacts'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            // Add button pressed
            // Perform the desired action here
          },
        ),
      ),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder:  (context, index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoListTile(
            padding: EdgeInsets.zero,
            leadingSize: 70,
            leadingToTitle: 0,
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.ibb.co/xM961wP/321556657089211.webp'),
            ),
            title: Text('Person $index',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('+8801512345678$index'),
            
          ),
          Divider(
            height: 0,
            indent: 65,
            color: CupertinoColors.systemGrey.withOpacity(.5),
          ),
          ],
        )
        ),
      /*
      child: ListView(
        children: [
          const CupertinoListTile(
            padding: EdgeInsets.zero,
            leadingSize: 70,
            leadingToTitle: 0,
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.ibb.co/xM961wP/321556657089211.webp'),
            ),
            title: Text('John Doe',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Hello! How are you?'),
            
          ),
          Divider(
            height: 0,
            indent: 60,
            color: CupertinoColors.systemGrey.withOpacity(.5),
          ),
          const CupertinoListTile(
            padding: EdgeInsets.zero,
            leadingSize: 70,
            leadingToTitle: 0,
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.ibb.co/xM961wP/321556657089211.webp'),
            ),
            title: Text('Jane Smith',style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Flutter is awesome!'),
            
          ),
          // Add more CupertinoListTiles for additional messages
        ],
      ),
      */
      );
  }
}