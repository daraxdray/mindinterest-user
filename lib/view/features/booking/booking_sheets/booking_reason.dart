import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

enum TherapyReason { depressed, specific, other }

class TherapyResonScreen extends StatelessWidget {
  const TherapyResonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'What led you to consider therapy today?',
        ),
        ColumnItemsSelector<TherapyReason>(
          verticalSpacing: 24,
          onChanged: (value) {},
          items: [
            VerticalItem(value: TherapyReason.depressed, text: "I'm depressed"),
            VerticalItem(
              value: TherapyReason.specific,
              text: 'I need to talk through a specific challenge',
            ),
            VerticalItem(value: TherapyReason.other, text: 'Other'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
