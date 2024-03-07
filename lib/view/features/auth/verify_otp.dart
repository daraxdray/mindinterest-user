// ignore_for_file: prefer_single_quotes, unused_import

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/hex_color.dart';
import 'package:mindintrest_user/view/global_widgets/async_aware.dart';
import 'package:mindintrest_user/view/global_widgets/decorated_page.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:mindintrest_user/view/global_widgets/pin_code_input.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class VerifyOTPScreen extends HookConsumerWidget {
  const VerifyOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authVM);
    return AsyncAwareWidget(
      inAsyncCall: provider.busy,
      child: TMIDecoratedPage(
        onBackPressed: provider.busy ? () {} : null,
        showBackButton: true,
        title: "Verify it's you",
        subtitle: "Let’s get you signed in, enter the code we sent you.",
        child: Column(
          children: [
            const Gap(32),
            TMIPinWidget(
              onSubmit: (otp) => provider.verifyOTP(context, otp),
            ),
            const Gap(24),
            if (provider.busy)
              const TMIButtonLoader(
                size: 18,
                color: kPrimaryColor,
              )
            else
              // Text(
              //   'Resend code',
              //   style: TextStyle(
              //     color: HexColor.fromHex('#6E7191'),
              //     fontSize: 13,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              const Gap(24),
            // TMIButton(
            //   buttonText: 'Verify Number',
            //   onPressed: () {

            //   },
            // ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
