import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, scrollIs) => [
          CupertinoSliverNavigationBar(
            border: Border.all(color: Colors.transparent),
            largeTitle: const Text("Contacts"),
            trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.add),
                onPressed: () {}),
            leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Summary"),
                onPressed: () {}),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
              child: CupertinoSearchTextField(
                placeholder: 'Search',
                onChanged: (text) {
                  // Perform search operation based on text input
                },
              ),
            ),
          ),
        ],
        body: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => Column(
              children: [
                CupertinoListTile(
                  leadingSize: 60,
                  leadingToTitle: 8,
                  leading: const CircleAvatar(backgroundImage: NetworkImage('https://cdn141.picsart.com/321556657089211.png'),radius: 23,),
                  title: Text('Data :: #$index',style: const TextStyle(fontWeight: FontWeight.w600),),
                  subtitle: Text('01234567890$index'),
                  ),
                  Divider(indent: 80,color: CupertinoColors.systemGrey.withOpacity(0.5),height: 5,)
              ],
            )),
      ),
    );
  }
}
