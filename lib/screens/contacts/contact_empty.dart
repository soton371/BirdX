import 'package:birdx/widgets/add_contact_dialog.dart';
import 'package:flutter/cupertino.dart';

class ContactEmpty extends StatelessWidget {
  const ContactEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/contacts.png",height: 70,width: 70,),
          const Text("\nThere are no any\ncontacts saved yet\n\n", textAlign: TextAlign.center,style: TextStyle(color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey, darkColor: CupertinoColors.systemGrey))),
          CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text("Add Contacts"), onPressed: ()=> addContactDialog(context))
        ],
      ),
    );
  }
}
