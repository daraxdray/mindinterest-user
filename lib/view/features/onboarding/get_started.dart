import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/doctor_illustration.png'),
              const Gap(64),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Talk to professionals that care about you',
                        textAlign: TextAlign.center,
                        style: AppStyles.getTextStyle(
                            color: kTitleActiveColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Book sessions with the best medical professionals that actually care about you.',
                        textAlign: TextAlign.center,
                        style: AppStyles.getTextStyle(
                            color: kPlaceHolderColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TMIButton(
                  buttonText: 'Get Started',
                  onPressed: () {
                    context.push(RoutePaths.login);
                  },
                ),
              ),
            ],
          ),
          const Gap(16),
          // RichText(
          //   text: TextSpan(
          //     text: 'Have an account already? ',
          //     style: AppStyles.getTextStyle(
          //       color: kLabelColor,
          //       fontSize: 13,
          //       fontWeight: FontWeight.w600,
          //     ),
          //     children: [
          //       TextSpan(
          //         text: 'Log In',
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () {
          //             context.push(RoutePaths.login);
          //           },
          //         style: AppStyles.getTextStyle(
          //           color: kPrimaryColor,
          //           fontSize: 13,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const Gap(64)
        ],
      ),
    );
  }
}
