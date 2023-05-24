import 'package:flutter/cupertino.dart';

void addContactDialog(BuildContext context) {
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: const Text("Add New Contact"),
            content: Column(
              children: [
                const SizedBox(height: 10,),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CupertinoColors.systemGrey.withOpacity(0.4)),
                    image: const DecorationImage(image: NetworkImage("https://cdn141.picsart.com/321556657089211.png"))
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CupertinoColors.systemGrey.withOpacity(0.4)),
                    color: CupertinoColors.black.withOpacity(0.35)
                  ),
                      ),
                      const Icon(CupertinoIcons.camera,color: CupertinoColors.white,),
                    ],
                  )),
                const SizedBox(height: 10,),
                const CupertinoTextField(
                  placeholder: "Enter name",
                ),
                const SizedBox(height: 10,),
                const CupertinoTextField(
                  placeholder: "Enter number",
                )
              ],
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDestructiveAction: true,
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                child: const Text('Add'),
                onPressed: () {},
              )
            ],
          ));
}
