import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

enum PanicAttack { yes, no }

class CurrentFeelingScreen extends StatelessWidget {
  const CurrentFeelingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderSubheaderRow(
          title:
              'Are you currently having panic anxiety, panic attacks or have any phobias?',
        ),
        ColumnItemsSelector<PanicAttack>(
          verticalSpacing: 24,
          onChanged: (value) {},
          items: [
            VerticalItem(value: PanicAttack.yes, text: 'Yes, I am'),
            VerticalItem(value: PanicAttack.no, text: 'No, I am not'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
