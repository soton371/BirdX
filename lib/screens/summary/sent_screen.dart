import 'package:birdx/configs/my_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SentScreen extends StatelessWidget {
  const SentScreen({super.key, required this.sentMsgs});
  final List sentMsgs;

  @override
  Widget build(BuildContext context) {
    return
        // sentMsgs.isEmpty
        //     ? const SummaryEmpty(isPending: 1)
        //     :
        ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 1,
          itemBuilder: (context, index)=>CupertinoListTile(
      leadingSize: 60,
      leadingToTitle: 8,
      padding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
        radius: 23,
      ),
      title: Text(
        "Soton Ahmed",
        style: TextStyle(
            fontSize: MyFonts.contactTitleSize,
            fontWeight: MyFonts.contactTitleWeight),
      ),
      subtitle: const Text(
        "The seminar is start now",
        maxLines: 1,
      ),
      trailing: const Column(
        children: [
          Text("Tue, Aug 15",
              style:
                  TextStyle(fontSize: 10, color: CupertinoColors.systemGrey)),
          Text("12:47 PM",
              style:
                  TextStyle(fontSize: 10, color: CupertinoColors.systemGrey)),
        ],
      ),
    )
          );
    
  }
}
