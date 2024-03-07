import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class SelectAgeScreen extends HookConsumerWidget {
  const SelectAgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);
    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'How old are you',
          subtitle:
              'Helps us personalize your experience with our psychologists',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        const Gap(24),
        ColumnItemsSelector<AgeRange>(
          value: provider.ageRange,
          verticalSpacing: 24,
          onChanged: (value) {
            provider
              ..ageRange = value
              ..notify();
          },
          items: [
            VerticalItem(value: AgeRange.below18, text: 'Below 18'),
            VerticalItem(value: AgeRange.a_18_24, text: '18 - 24'),
            VerticalItem(value: AgeRange.a_25_34, text: '25 - 34'),
            VerticalItem(value: AgeRange.a_35_44, text: '35 - 44'),
            VerticalItem(value: AgeRange.a_45_54, text: '45 - 54'),
            VerticalItem(value: AgeRange.a_55_65, text: '55 - 65'),
            VerticalItem(value: AgeRange.above65, text: 'Above 65'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
