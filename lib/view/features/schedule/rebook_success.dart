import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/utils/hex_color.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class RebookSuccessSheet extends HookConsumerWidget {
  const RebookSuccessSheet(
      {Key? key, this.startTime, this.consultantname, this.bookingDate})
      : super(key: key);
  final String? startTime;
  final String? consultantname;
  final DateTime? bookingDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(32),
      height: size.height * .7,
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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/hurray_icon.png'),
                ),
                const Gap(24),
                HeaderSubheaderRow(
                  textAlign: TextAlign.center,
                  title: 'Yay, your session has been re-booked',
                  subtitle: 'You have an appointment with Dr. $consultantname',
                ),
                const Gap(32),
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset(
                        'assets/images/calender.png',
                        color: kLabelColor,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      DateFormatter.formatDateFull(bookingDate),
                      style: AppStyles.getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBodyColor),
                    )
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    const SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(
                        Icons.timer,
                        color: kLabelColor,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      startTime!,
                      style: AppStyles.getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBodyColor),
                    )
                  ],
                )
              ],
            ),
          ),
          const Gap(32),
          Column(
            children: [
              TMIButton(
                buttonText: 'Close',
                onPressed: () {
                  ref.read(scheduleListingVM).notify();
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
