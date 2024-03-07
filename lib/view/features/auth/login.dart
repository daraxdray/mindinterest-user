// ignore_for_file: prefer_single_quotes, unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/async_aware.dart';
import 'package:mindintrest_user/view/global_widgets/decorated_page.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(authVM);
    return AsyncAwareWidget(
      inAsyncCall: provider.busy,
      child: TMIDecoratedPage(
        onBackPressed: provider.busy ? () {} : null,
        title: 'Get access',
        subtitle:
            "Let’s get you signed in,\nplease enter your number to proceed.",
        child: Column(
          children: [
            TMITextField(
              inputType: TextInputType.phone,
              maxLength: 14,
              labelText: 'Phone Number',
              hintText: '+18100000001',
              onChanged: (value) {
                ref.read(authVM).savePhone(value);
              },
            ),
            const Gap(32),
            TMIButton(
              enabled: provider.phone.length >= 11,
              busy: provider.busy,
              buttonText: 'Continue',
              onPressed: () {
                ref.read(authVM).requestOTP(context);
              },
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By continuing, you agree to The Mind Interest’s  ',
                      style: AppStyles.getTextStyle(
                        color: kPlaceHolderColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO: add impl
                            },
                          style: AppStyles.getTextStyle(
                            color: kPrimaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: AppStyles.getTextStyle(
                            color: kPlaceHolderColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO: add impl
                            },
                          style: AppStyles.getTextStyle(
                            color: kPrimaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
