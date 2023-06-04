import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_sizes.dart';
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
          Image.asset(
            "assets/images/contacts.png",
            height: MySizes.emptyIcon,
            width: MySizes.emptyIcon,
          ),
          Text("\nThere are no any\ncontacts saved yet\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(color: MyColors.emptyText)),
          CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: const Text("Add Contacts"),
              onPressed: () => addContactDialog(context))
        ],
      ),
    );
  }
}
