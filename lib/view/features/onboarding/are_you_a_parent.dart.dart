import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class ParentStatusScreen extends HookConsumerWidget {
  const ParentStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);

    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'Are you a parent?',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        ColumnItemsSelector<ParentStatus>(
          value: provider.parentStatus,
          verticalSpacing: 24,
          onChanged: (value) {
            provider
              ..parentStatus = value
              ..notify();
          },
          items: [
            VerticalItem(value: ParentStatus.yes, text: 'Yes'),
            VerticalItem(value: ParentStatus.no, text: 'No'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
