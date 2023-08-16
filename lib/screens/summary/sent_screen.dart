import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/summary/summary_empty.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SentScreen extends StatefulWidget {
  const SentScreen({super.key});

  @override
  State<SentScreen> createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {
  List<PendingMsgModel> sentMsgs = [];
  @override
  void initState() {
    super.initState();
    getPendingMsgs().then((value) {
      for (var element in value) {
        debugPrint("delivery element: ${element.statusIs}");
        if (element.statusIs == "1") {
          sentMsgs.add(element);
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return sentMsgs.isEmpty
        ? const SummaryEmpty(isPending: 1)
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: sentMsgs.length,
            itemBuilder: (context, index) {
              var data = sentMsgs[index];
              return CupertinoListTile(
                leadingSize: 60,
                leadingToTitle: 8,
                padding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 23,
                ),
                title: Text(
                  data.name,
                  style: TextStyle(
                      fontSize: MyFonts.contactTitleSize,
                      fontWeight: MyFonts.contactTitleWeight),
                ),
                subtitle: Text(
                  data.message,
                  maxLines: 1,
                ),
                trailing: Column(
                  children: [
                    Text(data.time.split('/').first,
                        style: const TextStyle(
                            fontSize: 10, color: CupertinoColors.systemGrey)),
                    Text(data.time.split('/').last,
                        style: const TextStyle(
                            fontSize: 10, color: CupertinoColors.systemGrey)),
                  ],
                ),
              );
            },
          );
  }
}
