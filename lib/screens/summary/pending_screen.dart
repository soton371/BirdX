import 'dart:async';

import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/message/message_scr.dart';
import 'package:birdx/screens/summary/summary_empty.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:birdx/utilities/time_to_seconds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen>
    with WidgetsBindingObserver {
  List<PendingMsgModel> pendingMsgs = [];
  final Telephony _telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    getPendingMsgs().then((value) {
      for (var element in value) {
        if (element.statusIs == "0") {
          pendingMsgs.add(element);
        }
      }
      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      for (var data in pendingMsgs) {
        DateTime fetchDT = DateTime.parse(data.dateTime);
        String differenceTime = fetchDT.difference(DateTime.now()).toString();
        int durationInSec = timeToSeconds(differenceTime);
        if (fetchDT.isAfter(DateTime.now())) {
          Future.delayed(
            Duration(seconds: durationInSec),
            () {
              _telephony.sendSms(to: data.number, message: data.message);
              // debugPrint("paused state send message");
              updatePendingMsg(
                      pendingMsgModel: data,
                      newName: data.name,
                      newNumber: data.number,
                      newMessage: data.message,
                      newDuration: data.durationInSec,
                      newTime: data.time,
                      newStatusIs: "1",
                      newDateTime: data.dateTime)
                  .then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SummaryScreen()));
              });
            },
          );
        } else {
          deletePendingMsg(data);
        }
      }
    }

    if (state == AppLifecycleState.detached) {
      for (var data in pendingMsgs) {
        DateTime fetchDT = DateTime.parse(data.dateTime);
        String differenceTime = fetchDT.difference(DateTime.now()).toString();
        int durationInSec = timeToSeconds(differenceTime);
        if (fetchDT.isAfter(DateTime.now())) {
          Future.delayed(
            Duration(seconds: durationInSec),
            () {
              _telephony.sendSms(to: data.number, message: data.message);
              // debugPrint("detached state send message");
              updatePendingMsg(
                      pendingMsgModel: data,
                      newName: data.name,
                      newNumber: data.number,
                      newMessage: data.message,
                      newDuration: data.durationInSec,
                      newTime: data.time,
                      newStatusIs: "1",
                      newDateTime: data.dateTime)
                  .then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SummaryScreen()));
              });
            },
          );
        } else {
          deletePendingMsg(data);
        }
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // debugPrint("WidgetsBinding.instance.removeObserver(this)");
    super.dispose();
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
              DateTime fetchDT = DateTime.parse(data.dateTime);
              String differenceTime =
                  fetchDT.difference(DateTime.now()).toString();
              int durationInSec = timeToSeconds(differenceTime);
              if (fetchDT.isAfter(DateTime.now())) {
                Future.delayed(
                  Duration(seconds: durationInSec),
                  () {
                    _telephony.sendSms(to: data.number, message: data.message);
                    // debugPrint("ListView.builder with send message");
                    updatePendingMsg(
                            pendingMsgModel: data,
                            newName: data.name,
                            newNumber: data.number,
                            newMessage: data.message,
                            newDuration: data.durationInSec,
                            newTime: data.time,
                            newStatusIs: "1",
                            newDateTime: data.dateTime)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SummaryScreen()));
                    });
                  },
                );
              } else {
                deletePendingMsg(data);
              }

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
                      Navigator.pushReplacement(
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
