import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void addContactDialog(BuildContext context) {
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: const Text("Add New Contact\n"),
            content: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CupertinoColors.systemGrey.withOpacity(0.4)),
                    image: const DecorationImage(image: NetworkImage("https://cdn141.picsart.com/321556657089211.png"))
                  ),
                  child: const Icon(CupertinoIcons.camera)),
                const SizedBox(width: 8,),
                const Column(
                  children: [
                    SizedBox(
                      width: 140,
                      child: CupertinoTextField(
                        placeholder: "enter name",
                      ),
                    ),
                    SizedBox(height: 6,),
                    SizedBox(
                      width: 140,
                      child: CupertinoTextField(
                        placeholder: "enter number",
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                child: const Text('Add'),
                onPressed: () {},
              )
            ],
          ));
}
