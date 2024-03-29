import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/message/message_scr.dart';
import 'package:birdx/screens/summary/summary_empty.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/services/my_background_services.dart';
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

class _PendingScreenState extends State<PendingScreen> with WidgetsBindingObserver {
  List<PendingMsgModel> pendingMsgs = [];
  final Telephony _telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    getPendingMsgs().then((value) {
      if (value.isEmpty) {
        return;
      }
      for (var element in value) {
        DateTime fetchDT = DateTime.parse(element.dateTime);
        if (element.statusIs == "0" || element.statusIs == "3") {
          pendingMsgs.add(element);
        } else if (element.statusIs == "0" && !fetchDT.isAfter(DateTime.now())) {
          updatePendingMsg(
              pendingMsgModel: element,
              newName: element.name,
              newNumber: element.number,
              newMessage: element.message,
              newDuration: element.durationInSec,
              newTime: element.time,
              newStatusIs: "3",
              newDateTime: element.dateTime);
        }
      }
      setState(() {});
    });
    MyBackgroundServices().stopBackgroundTask();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      if (pendingMsgs.isEmpty) {
        MyBackgroundServices().stopBackgroundTask();
        return;
      }
      MyBackgroundServices().startBackgroundTask();
    }

    if (state == AppLifecycleState.resumed) {
      MyBackgroundServices().stopBackgroundTask();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
              String differenceTime = fetchDT.difference(DateTime.now()).toString();
              int durationInSec = timeToSeconds(differenceTime);
              Future.delayed(
                Duration(seconds: durationInSec),
                () {
                  _telephony.sendSms(to: data.number, message: data.message);
                  // MyNotificationServices().showLocalNotification(title: "Send", body: data.message);
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
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => const SummaryScreen()));
                  });
                },
              );
              // }

              return CupertinoContextMenu(
                previewBuilder: (context, animation, child) {
                  return SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                    style: TextStyle(fontSize: MyFonts.contactTitleSize, fontWeight: MyFonts.contactTitleWeight),
                  ),
                  subtitle: Text(
                    data.message,
                    maxLines: 1,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(data.time.split('/').first, style: const TextStyle(fontSize: 10, color: CupertinoColors.systemGrey)),
                      data.statusIs == "3"
                          ? const Text("failed", style: TextStyle(fontSize: 10, color: CupertinoColors.systemRed))
                          : Text(data.time.split('/').last, style: const TextStyle(fontSize: 10, color: CupertinoColors.systemGrey)),
                    ],
                  ),
                ),
              );
            });
  }

}
