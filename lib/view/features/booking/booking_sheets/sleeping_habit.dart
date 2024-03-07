import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

enum SleepPattern { sevenHours, fiveHours, lessThanFour }

class SleepingHabitScreen extends StatelessWidget {
  const SleepingHabitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'How would you rate your current sleeping habits?',
        ),
        ColumnItemsSelector<SleepPattern>(
          verticalSpacing: 24,
          onChanged: (value) {},
          items: [
            VerticalItem(
              value: SleepPattern.sevenHours,
              text: 'Good, I get 7 hours of sleep',
            ),
            VerticalItem(
              value: SleepPattern.fiveHours,
              text: 'Fair, I get 5 hours of sleep',
            ),
            VerticalItem(
              value: SleepPattern.lessThanFour,
              text: 'Poor, I get less than 4 hours',
            ),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
