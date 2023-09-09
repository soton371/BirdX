import 'package:birdx/configs/my_sizes.dart';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/screens/summary/summary_screen.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:birdx/utilities/time_to_seconds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {super.key, required this.name, required this.number, this.pendingMsg});

  final String? name, number;
  final PendingMsgModel? pendingMsg;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String msg = '';
  TextEditingController msgController = TextEditingController();
  DateTime _chosenDateTime = DateTime.now().add(const Duration(minutes: 2));
  String formattedDate = '';
  String formattedTime = '';
  String initShowDate = DateFormat.MMMEd().format(DateTime.now());
  String initTime =
      DateFormat.jms().format(DateTime.now().add(const Duration(minutes: 2)));
  int mySec = 0;


  @override
  void initState() {
    super.initState();
    var m = widget.pendingMsg;
    if (m != null) {
      msg = m.message;
      msgController = TextEditingController(text: msg);
      mySec = int.parse(m.durationInSec);
      _chosenDateTime = DateTime.parse(m.dateTime);
      formattedDate = DateFormat.MMMEd().format(_chosenDateTime);
      formattedTime = DateFormat.jms().format(_chosenDateTime);
      return;
    }
    formattedDate = DateFormat.MMMEd().format(_chosenDateTime);
    formattedTime = DateFormat.jms().format(_chosenDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.name ?? 'Contact Name'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MySizes.bodyPadding),
          child: Column(
            children: [
              //add date time picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate.isEmpty ? initShowDate : formattedDate,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        formattedTime.isEmpty ? initTime : formattedTime,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _showDatePicker(context),
                      child: const Icon(CupertinoIcons.pen))
                ],
              ),
              //end date time picker

              //add message box
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\n\nMessage',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 8,
                    ),
                    CupertinoTextField(
                      placeholder: "Type Message",
                      controller: msgController,
                      maxLines: 5,
                      onChanged: (v) {
                        setState(() {
                          msg = v;
                        });
                      },
                    )
                  ],
                ),
              ),
              //end message box

              //add for button
              msg.trim().isEmpty
                  ? const SizedBox()
                  : widget.pendingMsg != null
                      ? CupertinoButton.filled(
                          onPressed: () {
                            var g = widget.pendingMsg;
                            if (g != null) {
                              updatePendingMsg(
                                  pendingMsgModel: g,
                                  newName: widget.name ?? '',
                                  newNumber: widget.number ?? '',
                                  newMessage: msg,
                                  newDuration: mySec.toString(),
                                  newTime: "$formattedDate / $formattedTime",
                                  newStatusIs: "0",
                                  newDateTime: _chosenDateTime.toString());
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) => const SummaryScreen()));
                            }
                          },
                          child: const Text("Update"))
                      : SliderButton(
                          action: () {
                            Duration differenceTime =
                                _chosenDateTime.difference(DateTime.now());
                            mySec = timeToSeconds(differenceTime.toString());
                            addPendingMsg(
                                    name: widget.name ?? '',
                                    number: widget.number ?? '',
                                    message: msg,
                                    duration: mySec.toString(),
                                    time: "$formattedDate / $formattedTime",
                                    statusIs: "0",
                                    dateTime: _chosenDateTime.toString())
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) => const SummaryScreen()));
                            });
                          },
                          dismissible: false,
                          label: const Text(
                            "Slide to send message",
                            style: TextStyle(
                                color: Color(0xff4a4a4a),
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          icon: const Icon(CupertinoIcons.forward),
                          height: 55,
                          buttonSize: 50,
                          width: double.maxFinite,
                          alignLabel: Alignment.center,
                          radius: 10,
                        ),
              //end for button
            ],
          ),
        ),
      ),
    );
  }

  //all method
  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 302,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close the modal
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),

                //date convert
                CupertinoButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    formattedDate = DateFormat.MMMEd().format(_chosenDateTime);
                    formattedTime = DateFormat.jms().format(_chosenDateTime);
                    debugPrint(
                        "formattedDate: $formattedDate , formattedTime: $formattedTime");
                    setState(() {});
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                  initialDateTime:
                      DateTime.now().add(const Duration(minutes: 3)),
                  minimumDate: DateTime.now().add(const Duration(minutes: 2)),
                  maximumDate: DateTime.now().add(const Duration(days: 60)),
                  onDateTimeChanged: (val) {
                    setState(() {
                      _chosenDateTime = val;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
