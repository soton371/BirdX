import 'package:birdx/configs/my_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, this.name});
  final String? name;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String msg = '';
  DateTime _chosenDateTime = DateTime.now();
  String formattedDate = '';
  String formattedTime = '';
  String initShowDate = DateFormat.MMMEd().format(DateTime.now());
  String initTime = DateFormat.jm().format(DateTime.now().add(const Duration(minutes: 5)));

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
              msg.isEmpty
                  ? const SizedBox()
                  : SliderButton(
                      action: () {},
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
  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
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
                          debugPrint("_chosenDateTime: $_chosenDateTime");
                          formattedDate =
                              DateFormat.MMMEd().format(_chosenDateTime);
                          formattedTime =
                              DateFormat.jm().format(_chosenDateTime);
                          debugPrint("formattedDate: $formattedDate, formattedTime: $formattedTime");
                          setState(() {
                            
                          });
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 250,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now().add(const Duration(minutes: 5)),
                        minimumDate: DateTime.now().add(const Duration(minutes: 4)),
                        maximumDate: DateTime.now().add(const Duration(days: 10)),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }
}
