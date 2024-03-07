import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/utils/utils.dart';
import 'package:mindintrest_user/view/features/schedule/booked_detail_sheet.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class ScheduleCourosel extends StatefulWidget {
  const ScheduleCourosel({Key? key, required this.bookings}) : super(key: key);
  final List<Booking> bookings;

  @override
  _ScheduleCouroselState createState() => _ScheduleCouroselState();
}

class _ScheduleCouroselState extends State<ScheduleCourosel> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: PageView(
          children: widget.bookings
              .map((e) => ScheduleCard(
                    booking: e,
                    isActive: true,
                    // isActive: true,
                  ))
              .toList(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      const Gap(12),
      ScrollDots(
        length: widget.bookings.length,
        currentIndex: _currentIndex,
      )
    ]);
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, this.isActive = false, required this.booking})
      : super(key: key);
  final bool isActive;
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive
          ? null
          : () async {
              await showAppDialog<void>(context,
                  // dismissible: false,
                  child: BookedSessionSummarySheet(
                    booking: booking,
                  ));
            },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isActive ? kPrimaryDark : kSecondaryDark,
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            alignment: Alignment.topRight,
            colorFilter:
                ColorFilter.mode(kLineColor.withOpacity(.2), BlendMode.srcIn),
            image: const AssetImage('assets/images/schedule_bg.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormatter.formatDayAndMonth(booking.parsedStartDate),
              style: AppStyles.getTextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: kWhite,
              ),
            ),
            Text(
              '${Utils.getTimeFromDigit(booking.startTime!)} - ${Utils.getTimeFromDigit(booking.endTime!)}',
              style: AppStyles.getTextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: kWhite,
              ),
            ),

            const Spacer(),
            Row(
              children: [
                // const UserAvatar(
                //   ringColor: kWhite,
                //   // ringSize: 1.5,
                //   url: booking.therapist!,
                //   height: 32,
                //   width: 32,
                // ),
                // const Gap(8),
                Flexible(
                  child: HeaderSubheaderRow(
                    title: 'Dr. ${booking.therapist}',
                    subtitle: '', //TODO: fix this
                    titleStyle: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: kWhite,
                    ),
                    subtitleStyle: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: kWhite,
                    ),
                  ),
                ),
                if (isActive)
                  TMIButton(
                    height: 40,
                    horizontalPadding: 18,
                    onPressed: () {
                      //Schedule is active
                      GoRouter.of(context).push(RoutePaths.conversationScreen +
                          "?cid=${booking.cid}&bid=${booking.conversationId}&meetLink=${booking.meetLink}");
                    },
                    buttonText: 'Go to session',
                    buttonColor: kWhite,
                    textColor: kPrimaryDark,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ScrollDots extends StatelessWidget {
  const ScrollDots({
    Key? key,
    required this.length,
    this.currentIndex = 0,
    this.inactiveColor = kInputBGColor,
    this.activeColor = kPrimaryColor,
  }) : super(key: key);

  final int length;
  final int currentIndex;
  final Color inactiveColor;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          height: 6,
          width: 6,
          decoration: index == currentIndex
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeColor,
                )
              : BoxDecoration(
                  shape: BoxShape.circle,
                  color: inactiveColor,
                ),
        ),
      ),
    );
  }
}
