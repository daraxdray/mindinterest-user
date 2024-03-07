import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/global_widgets/screen_animations.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class TMIDecoratedPage extends StatelessWidget {
  const TMIDecoratedPage({
    Key? key,
    required this.child,
    this.showBackButton = false,
    this.showCloseButton = true,
    this.fit,
    this.title = '',
    this.subtitle = '',
    this.scrollChild = true,
    this.floatingActionButton,
    this.addPadding = true,
    this.onBackPressed,
    this.titleTextAlign = TextAlign.center,
    this.onClosePressed,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.stickyBottom = const SizedBox(),
  }) : super(key: key);
  final Column child;
  final bool showBackButton;
  final Widget stickyBottom;
  final String title;
  final String subtitle;
  final BoxFit? fit;
  final bool? scrollChild;
  final FloatingActionButton? floatingActionButton;
  final bool addPadding;
  final bool showCloseButton;
  final void Function()? onBackPressed;
  final void Function()? onClosePressed;
  final TextAlign titleTextAlign;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeIn(
        delay: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              children: [
                const Gap(24),
                Row(
                  children: [
                    if (showBackButton)
                      TMIBackButton(
                        onPressed: onBackPressed,
                      ),
                    const Spacer(),
                    if (showCloseButton)
                      TMICloseButton(
                        onPressed: onClosePressed,
                      )
                  ],
                ),
                const Gap(24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        textAlign: titleTextAlign,
                        style: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: kTitleActiveColor,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        textAlign: titleTextAlign,
                        style: AppStyles.getTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: kLabelColor,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(24),
                if (scrollChild == true)
                  Expanded(
                    child: SingleChildScrollView(
                      child: child,
                    ),
                  )
                else
                  child,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: stickyBottom,
      floatingActionButton: floatingActionButton,
    );
  }
}
