import 'package:birdx/models/pending_msg_mod.dart';
import 'package:flutter/cupertino.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key,required this.pendingMsgs});
  final List<PendingMsgModel> pendingMsgs;

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("pendingMsgs: ${widget.pendingMsgs.length}")
        ],
      ),
    );
  }
}