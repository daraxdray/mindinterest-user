import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class RelationshipStatusDurationScreen extends HookConsumerWidget {
  const RelationshipStatusDurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);

    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'How long have you had this relationship status?',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        ColumnItemsSelector<RelationshipStatusDuration>(
          value: provider.relationshipStatusDuration,
          verticalSpacing: 24,
          onChanged: (value) {
            provider
              ..relationshipStatusDuration = value
              ..notify();
          },
          items: [
            VerticalItem(
                value: RelationshipStatusDuration.fewMonths,
                text: 'A few months'),
            VerticalItem(
                value: RelationshipStatusDuration.fewYears,
                text: 'A few years'),
            VerticalItem(
                value: RelationshipStatusDuration.fivePlus, text: '5+ years'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
