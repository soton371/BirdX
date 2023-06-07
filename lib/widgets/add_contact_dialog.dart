import 'package:birdx/utilities/contact_crud.dart';
import 'package:flutter/cupertino.dart';

void addContactDialog(BuildContext context) {
  String name = '';
  String number = '';
  // File? image;
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: const Text("Add New Contact"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  /*
                  GestureDetector(
                    onTap: () async {
                      final action = CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            onPressed: () {
                              myImagePicker(type: 0).then((value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  image = File(value);
                                });
                                Navigator.pop(context);
                              });
                            },
                            child: const Text("Take Photo"),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              myImagePicker(type: 1).then((value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  image = File(value);
                                });
                                Navigator.pop(context);
                              });
                            },
                            child: const Text("Choose Photo"),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      );

                      showCupertinoModalPopup(
                          context: context, builder: (context) => action);
                    },
                    child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: CupertinoColors.systemGrey
                                    .withOpacity(0.4)),
                            image: const DecorationImage(
                                image: AssetImage("assets/images/avatar.png"))),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            image == null
                                ? Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: CupertinoColors.systemGrey
                                                .withOpacity(0.4)),
                                        color: CupertinoColors.black
                                            .withOpacity(0.35)),
                                  )
                                : Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: CupertinoColors.systemGrey
                                                .withOpacity(0.4)),
                                        color: CupertinoColors.black
                                            .withOpacity(0.35),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(image!))),
                                  ),
                            const Icon(
                              CupertinoIcons.camera,
                              color: CupertinoColors.white,
                            ),
                          ],
                        )),
                  ),
                  */
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextField(
                    placeholder: "Enter name",
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextField(
                    placeholder: "Enter number",
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      number = value;
                    },
                  )
                ],
              );
            }),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDestructiveAction: true,
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                child: const Text('Save'),
                onPressed: () {
                  addContact(name: name, number: number);
                  //check all input not empty
                },
              )
            ],
          ));
}
