import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class CancelBookingConfirmationSheet extends HookConsumerWidget {
  const CancelBookingConfirmationSheet({Key? key, required this.cancel})
      : super(key: key);
  final void Function() cancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(12),

          const HeaderSubheaderRow(
            verticalSpacing: 12,
            textAlign: TextAlign.center,
            title: 'Are you sure you want to cancel?',
            subtitle:
                'Cancelling your session is never adviced but it’s understandable, your refund should be in your account in the next hour.',
          ),
          // const Gap(18),

          const Gap(32),
          Row(
            children: [
              Expanded(
                child: TMIButton(
                  height: 40,
                  buttonColor: kWhite,
                  textColor: kPrimaryColor,
                  buttonText: 'Yes',
                  onPressed: cancel,
                ),
              ),
              const Gap(18),
              Expanded(
                child: TMIButton(
                  height: 40,
                  buttonText: 'No',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
