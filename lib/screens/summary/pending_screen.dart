import 'dart:async';

import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/message/message_scr.dart';
import 'package:birdx/screens/summary/summary_empty.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  List<PendingMsgModel> pendingMsgs = [];
  @override
  void initState() {
    super.initState();
    getPendingMsgs().then((value) {
      for (var element in value) {
        debugPrint("pending element: ${element.statusIs}");
        if (element.statusIs == "0") {
          pendingMsgs.add(element);
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return pendingMsgs.isEmpty
        ? const SummaryEmpty(
            isPending: 0,
          )
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: pendingMsgs.length,
            itemBuilder: (context, index) {
              var data = pendingMsgs[index];
              Timer(Duration(seconds: int.parse(data.durationInSec)), () {
                // _telephony.sendSms(
                //     to: widget.number ?? '', message: msg);
                updatePendingMsg(
                        pendingMsgModel: data,
                        newName: data.name,
                        newNumber: data.number,
                        newMessage: data.message,
                        newDuration: data.durationInSec,//check time
                        newTime: data.time,
                        newStatusIs: "1")
                    .then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const SummaryScreen()));
                });
              });
              return CupertinoContextMenu(
                previewBuilder: (context, animation, child) {
                  return SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data.message,
                          maxLines: 3,
                          style: TextStyle(color: MyColors.emptyText),
                        ),
                      ),
                    ),
                  );
                },
                actions: [
                  CupertinoContextMenuAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => MessageScreen(
                                    name: data.name,
                                    number: data.number,
                                    pendingMsg: data,
                                  )));
                    },
                    trailingIcon: CupertinoIcons.pen,
                    child: const Text("Edit"),
                  ),
                  CupertinoContextMenuAction(
                    onPressed: () {
                      deletePendingMsg(data).then((value) {
                        getPendingMsgs().then((value) {
                          Navigator.pop(context);
                          setState(() {
                            pendingMsgs = value;
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
                ),
              );
            });
  }
}
