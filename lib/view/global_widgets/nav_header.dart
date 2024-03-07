import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class NavHeader extends StatelessWidget {
  const NavHeader({
    Key? key,
    this.title = '',
    this.onBackPressed,
    this.onClosePressed,
    this.iconColor,
    this.showBackButton = true,
    this.showCloseButton = true,
  }) : super(key: key);
  final void Function()? onBackPressed;
  final String title;
  final void Function()? onClosePressed;
  final bool showBackButton;
  final bool showCloseButton;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          TMIBackButton(
            iconColor: iconColor,
            onPressed: onBackPressed,
          ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.getTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: .2,
              color: kTitleActiveColor,
            ),
          ),
        ),
        if (showCloseButton)
          TMICloseButton(
            iconColor: iconColor,
            onPressed: onClosePressed,
          )
      ],
    );
  }
}
