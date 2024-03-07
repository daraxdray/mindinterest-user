// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/decorated_page.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';

class GetFullNameScreen extends HookConsumerWidget {
  const GetFullNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);
    return Column(
      children: [
        const HeaderSubheaderRow(
          title: 'What’s your full name?',
          titleMaxLines: 99,
          subtitleMaxLines: 99,
        ),
        TMITextField(
          onChanged: (data) {
            provider.notify();
          },
          controller: provider.firstNameController,
          hintText: 'First Name',
          labelText: 'First Name',
          inputType: TextInputType.text,
        ),
        const Gap(16),
        TMITextField(
          onChanged: (_) => provider.notify(),
          controller: provider.lastNameController,
          hintText: 'Last Name',
          labelText: 'Last Name',
            inputType: TextInputType.text
        ),
        const Gap(32),
      ],
    );
  }
}
