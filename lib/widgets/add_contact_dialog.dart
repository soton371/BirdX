import 'package:birdx/utilities/contact_crud.dart';
import 'package:birdx/utilities/input_validation.dart';
import 'package:flutter/cupertino.dart';

Future addContactDialog(BuildContext context) {
  String name = '';
  String number = '';
  var r = showCupertinoDialog(
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
                  bool valid =
                      inputValidation(context, name: name, number: number);
                  if (valid) {
                    addContact(name: name, number: number).then((value) {
                      debugPrint("value: $value");
                    });
                  }
                },
              )
            ],
          ));
  return r;
}
