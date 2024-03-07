import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class SelectGenderScreen extends HookConsumerWidget {
  const SelectGenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const HeaderSubheaderRow(
          titleMaxLines: 99,
          subtitleMaxLines: 99,
          title: 'What’s your gender?',
        ),
        ColumnItemsSelector<Gender>(
          value: ref.read(authVM).gender,
          verticalSpacing: 24,
          onChanged: (value) {
            ref.read(authVM)
              ..gender = value
              ..notify();
          },
          items: [
            VerticalItem(value: Gender.male, text: 'Male'),
            VerticalItem(value: Gender.female, text: 'Female'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
