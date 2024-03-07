import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';

class GreetingScreen extends HookConsumerWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Hi ${provider.firstNameController.text},',
          style: AppStyles.getTextStyle(
              fontWeight: FontWeight.w400,
              color: kLabelColor,
              fontSize: 20,
              letterSpacing: 0.2),
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: Text(
                'Let’s walk through the process of finding the best therapist for you! We’ll start with some questions.',
                style: AppStyles.getTextStyle(
                    fontWeight: FontWeight.w400,
                    color: kTitleActiveColor,
                    fontSize: 24,
                    letterSpacing: 0.25),
              ),
            )
          ],
        )
      ],
    );
  }
}
