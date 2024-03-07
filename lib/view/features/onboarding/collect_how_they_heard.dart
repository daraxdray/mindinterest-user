// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/vertical_text_selector.dart';

class HowDidYouHear extends HookConsumerWidget {
  const HowDidYouHear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);
    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'How’d you hear about Mind Interest',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        const Gap(24),
        ColumnItemsSelector<ReferalMedium>(
          value: provider.referalMedium,
          verticalSpacing: 24,
          onChanged: (value) {
            provider
              ..referalMedium = value
              ..notify();
          },
          items: [
            VerticalItem(
                value: ReferalMedium.wordOfMouth, text: 'Word of mouth'),
            VerticalItem(value: ReferalMedium.snapchat, text: 'Snapchat'),
            VerticalItem(
                value: ReferalMedium.newsArticle, text: 'News  Article'),
            VerticalItem(
                value: ReferalMedium.meta, text: 'Instagram of Facebook'),
            VerticalItem(value: ReferalMedium.tiktok, text: 'Tiktok'),
            VerticalItem(value: ReferalMedium.google, text: 'Google'),
            VerticalItem(value: ReferalMedium.youtube, text: 'Youtube'),
            VerticalItem(value: ReferalMedium.other, text: 'Other'),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}
