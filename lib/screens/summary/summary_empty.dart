import 'package:flutter/cupertino.dart';

class SummaryEmpty extends StatelessWidget {
  const SummaryEmpty({super.key, required this.isPending});
  final int isPending;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(isPending == 0 ? "assets/images/paper-plane.png" : "assets/images/contacts.png", height: 100, width: 100),
          const Text("\nNo Communication History",
              textAlign: TextAlign.center,
              style: TextStyle(color: CupertinoColors.systemGrey)),
        ],
      ),
    );
  }
}
