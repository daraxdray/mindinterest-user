import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';

enum ButtonIconPosition { left, right }

class TMIButton extends StatelessWidget {
  const TMIButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.textColor = Colors.white,
    this.busy = false,
    this.buttonColor = kPrimaryColor,
    this.enabled = true,
    this.fontSize,
    this.fontWeight,
    this.height = 50,
    this.horizontalPadding = 24,
    this.showIcon = false,
    this.borderRadius = 24,
    this.borderColor = kPrimaryColor,
    this.buttonIconPosition = ButtonIconPosition.right,
    this.icon,
  }) : super(key: key);
  final String buttonText;
  final void Function()? onPressed;
  final Widget? icon;
  final bool busy;
  final Color buttonColor;
  final Color textColor;
  final bool enabled;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool showIcon;
  final double borderRadius;
  final ButtonIconPosition buttonIconPosition;
  final double height;
  final double horizontalPadding;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final List rowChildren = <Widget>[
      Text(
        buttonText,
        style: AppStyles.getTextStyle(
          color: textColor,
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize ?? 16,
        ),
      ),

      ///if show icon is through and a custom icon is passed
      ///show that, else show the default button icon
      if (showIcon)
        if (icon != null) ...[
          const Gap(8),
          icon!
        ] else ...[
          const Gap(8),
          defaultIcon()
        ]
    ];

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: enabled ? buttonColor : kPrimaryColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            width: 2,
            color: enabled ? borderColor : kPrimaryColor.withOpacity(.2),
          ),
        ),
        height: height,
        child: Center(
          child: busy
              ? TMIButtonLoader(
                  color: textColor,
                  size: 22,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: buttonIconPosition == ButtonIconPosition.right
                      ? rowChildren as List<Widget>
                      : rowChildren.reversed.toList() as List<Widget>,
                ),
        ),
      ),
    );
  }

  Widget defaultIcon() => const Icon(
        Icons.east,
        color: kWhite,
        size: 20,
      );
}

class TMIBackButton extends StatelessWidget {
  const TMIBackButton({Key? key, this.onPressed, this.iconColor})
      : super(key: key);

  final void Function()? onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => GoRouter.of(context).pop(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
              size: 18,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

class TMICloseButton extends StatelessWidget {
  const TMICloseButton({Key? key, this.onPressed, this.iconColor})
      : super(key: key);

  final void Function()? onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => GoRouter.of(context).pop(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.close,
            size: 18,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
