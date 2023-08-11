import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_fonts.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/summary/summary_empty.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingScreen extends StatefulWidget {
  PendingScreen({super.key, required this.pendingMsgs});
  List<PendingMsgModel> pendingMsgs;

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.pendingMsgs.isEmpty
        ? const SummaryEmpty(
            isPending: 0,
          )
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: widget.pendingMsgs.length,
            itemBuilder: (context, index) {
              var data = widget.pendingMsgs[index];
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
                      // updateContactDialog(contacts[index]);
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
                            widget.pendingMsgs = value;
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
