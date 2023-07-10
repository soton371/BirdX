import 'package:birdx/screens/summary/summary_empty.dart';
import 'package:flutter/material.dart';

class SentScreen extends StatelessWidget {
  const SentScreen({super.key, required this.sentMsgs});
  final List sentMsgs;

  @override
  Widget build(BuildContext context) {
    return sentMsgs.isEmpty ? const SummaryEmpty(isPending: 1):
    const Center(
      child: Text('Sent Screen'),
    );
  }
}
