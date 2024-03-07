import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class EnableNotificationSheet extends StatelessWidget {
  const EnableNotificationSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          const BottomSheetCapsule(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavHeader(
                  showBackButton: false,
                  title: 'Enable notifications',
                  onClosePressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Gap(24),
                SizedBox(
                  height: 104,
                  width: 104,
                  child: Image.asset(
                      'assets/images/notification_request_icon.png'),
                ),
                const Gap(12),
                const HeaderSubheaderRow(
                  title: 'Stay Updated',
                  subtitle:
                      'We’d like to keep you updated on changes to  appointments, postponements and app updates.',
                ),
                const Spacer(),
                TMIButton(
                  buttonText: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go(RoutePaths.dashboardIndex);
                  },
                ),
                const Gap(24)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
