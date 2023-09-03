import 'package:birdx/screens/summary/pending_screen.dart';
import 'package:birdx/screens/summary/sent_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int? _sliding = 0;

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
                    ),
                  ),
                  1: Text(
                    'Sent',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w600,
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
        const PendingScreen():const SentScreen(),
      ),
    );
  }
}
