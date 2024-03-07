import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class NeedToTalkScreen extends HookConsumerWidget {
  const NeedToTalkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);

    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'How often do you feel the need to talk to someone?',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        const Gap(24),
        ColumnItemsSelector<NeedToTalk>(
          value: provider.needToTalk,
          verticalSpacing: 24,
          onChanged: (value) {
            provider
              ..needToTalk = value
              ..notify();
          },
          items: [
            VerticalItem(value: NeedToTalk.allTheTime, text: 'All the time'),
            VerticalItem(value: NeedToTalk.mostTimes, text: 'Most of the time'),
            VerticalItem(value: NeedToTalk.sometimes, text: 'Sometimes'),
            VerticalItem(value: NeedToTalk.none, text: 'Not at all'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
