import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/summary/pending_screen.dart';
import 'package:birdx/screens/summary/sent_screen.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int? _sliding = 0;
  List<PendingMsgModel> pendingMsgList = [];

  @override
  void initState() {
    super.initState();
    getPendingMsgs().then((value) {
      setState(() {
        pendingMsgList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, scrollIs) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text(_sliding == 0 ? "Pending" : "Sent"),
            middle: CupertinoSlidingSegmentedControl(
                children: {
                  0: Text(
                    'Pending',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleSmall!.fontSize,
                        fontWeight: FontWeight.w600,
                        color: MyColors.segmentedControlText(context)),
                  ),
                  1: Text(
                    'Sent',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w600,
                      color: MyColors.segmentedControlText(context),
                    ),
                  ),
                },
                groupValue: _sliding,
                onValueChanged: (newValue) {
                  setState(() {
                    _sliding = newValue;
                  });
                }),
          ),
        ],
        body:_sliding==0 ?
        PendingScreen(pendingMsgs: pendingMsgList,):const SentScreen(sentMsgs: [],),
      ),
    );
  }
}
