import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';

class PastSessionWidget extends StatelessWidget {
  const PastSessionWidget({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.07),
            blurRadius: 18,
            spreadRadius: 7,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Gap(12),
              UserAvatar(
                height: 36,
                width: 36,
                url: booking.therapistPictureUrl!,
              ),
              const Gap(12),
              Expanded(
                child: HeaderSubheaderRow(
                  title: 'Dr. ${booking.therapist}',
                  // subtitle: booking.t,
                  titleStyle: AppStyles.getTextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: kTitleActiveColor,
                  ),
                  subtitleStyle: AppStyles.getTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: kLabelColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormatter.formatDateFull(DateTime.tryParse(booking.date!)),
                style: AppStyles.getTextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                  color: kBodyColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
