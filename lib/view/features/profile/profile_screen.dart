import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: kWhite,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(32),
          UserAvatar(
            url: user.profileImg!,
          ),
          const Gap(12),
          HeaderSubheaderRow(
            textAlign: TextAlign.center,
            titleStyle: AppStyles.getTextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: kTitleActiveColor),
            title: user.name!,
            subtitle: user.phone!,
          ),
          const Gap(24),
          SizedBox(
            width: 100,
            child: TMIButton(
              height: 40,
              buttonText: 'Edit',
              onPressed: () {
                context.push(RoutePaths.editProfileScreen);
              },
            ),
          ),
          const Gap(32),
          rowHeader('preferences'),
          const Gap(24),
          row(
            assetPath: 'assets/images/profile.png',
            title: 'Personalize Experience',
            onTap: () {
              ref.read(authVM).initializeProfilePersonalization();
              context.push(RoutePaths.personaliseProfileScreen);
            },
          ),
          // const Gap(24),
          // row(
          //   assetPath: 'assets/images/language_2.png',
          //   title: 'Language',
          // ),
          const Gap(24),
          row(
            assetPath: 'assets/images/support.png',
            title: 'Get Support',
          ),
          const Gap(24),
          row(
            assetPath: 'assets/images/logout.png',
            title: 'Log Out',
            onTap: () async {
              await ref.read(authVM).logOut(context);
            },
          ),
        ],
      ),
    );
  }

  Widget rowHeader(String text) {
    return Container(
      color: kBgColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Text(
            text.toUpperCase(),
            style: AppStyles.getTextStyle(
                fontSize: 10, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget row({
    required String assetPath,
    required String title,
    void Function()? onTap,
    Widget trailing = const SizedBox(),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              height: 18,
              width: 18,
              child: Image.asset(
                assetPath,
                color: kPlaceHolderColor,
              ),
            ),
            const Gap(24),
            Text(
              title,
              style: AppStyles.getTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: kTitleActiveColor,
              ),
            ),
            const Spacer(),
            trailing
          ],
        ),
      ),
    );
  }
}
