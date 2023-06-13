import 'package:birdx/configs/my_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forked_slider_button/forked_slider_button.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, this.name});
  final String? name;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String msg = '';

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
                        "Mon, Jun 12",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '9:30 PM',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
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
}
