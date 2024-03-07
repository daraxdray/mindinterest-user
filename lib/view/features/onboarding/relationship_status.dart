import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class RelationshipStatusScreen extends HookConsumerWidget {
  const RelationshipStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);

    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'What’s your relationship status?',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        const Gap(24),
        ColumnItemsSelector<RelationshipStatus>(
          value: provider.relationshipStatus,
          verticalSpacing: 24,
          onChanged: (value) {
            provider
              ..relationshipStatus = value
              ..notify();
          },
          items: [
            VerticalItem(
              value: RelationshipStatus.single,
              text: 'Single',
            ),
            VerticalItem(
              value: RelationshipStatus.dating,
              text: 'Dating',
            ),
            VerticalItem(
              value: RelationshipStatus.married,
              text: 'Maried',
            ),
            VerticalItem(
              value: RelationshipStatus.separated,
              text: 'Instagram of Facebook',
            ),
            VerticalItem(value: RelationshipStatus.other, text: 'Other'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
