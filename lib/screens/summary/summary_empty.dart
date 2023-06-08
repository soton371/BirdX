import 'package:birdx/configs/my_colors.dart';
import 'package:birdx/configs/my_sizes.dart';
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
          Image.asset(
              isPending == 0
                  ? "assets/images/parachute.png"
                  : "assets/images/miyaw.png",
              height: MySizes.emptyIcon,
              width: MySizes.emptyIcon),
          Text("\nNo Communication History",
              textAlign: TextAlign.center,
              style: TextStyle(color: MyColors.emptyText)),
        ],
      ),
    );
  }
}
