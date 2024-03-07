
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/utils/hex_color.dart';
import 'package:mindintrest_user/view/features/onboarding/notification_pop_up.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';

class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HexColor.fromHex('#92D5EB'), HexColor.fromHex('#FFFDE4')],
            stops: const [0, 1],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/hurray_icon.png'),
                  ),
                  const Gap(24),
                  const HeaderSubheaderRow(
                    textAlign: TextAlign.center,
                    title: 'We did it yay!',
                    subtitle:
                        'We’re so happy to have you on, now go experience everything we have to offer!',
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showAppBottomSheet<void>(
                  context,
                  child: const EnableNotificationSheet(),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: kPrimaryColor),
                child: const Icon(
                  Icons.chevron_right,
                  color: kWhite,
                  size: 32,
                ),
              ),
            ),
            const Gap(32)
          ],
        ),
      ),
    );
  }
}
