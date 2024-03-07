import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/utils/utils.dart';
import 'package:mindintrest_user/view/features/schedule/cancel_booking_sheet.dart';
import 'package:mindintrest_user/view/features/schedule/rebook_slot.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/summary_row.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class BookedSessionSummarySheet extends HookConsumerWidget {
  const BookedSessionSummarySheet({Key? key, required this.booking})
      : super(key: key);
  final Booking booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(bookingVM);
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeaderSubheaderRow(
            textAlign: TextAlign.center,
            title: 'You booked a session',
            titleMaxLines: 99,
          ),
          const Gap(24),
          SummaryRowWidget(
              title: 'Therapist', data: 'Dr. ${booking.therapist}'),
          SummaryRowWidget(
              title: 'Date',
              data: DateFormatter.formatDateFull(
                  DateTime.tryParse(booking.date!))),
          SummaryRowWidget(
            title: 'Time',
            data:
                "${Utils.getTimeFromDigit(booking.startTime!)} - ${Utils.getTimeFromDigit(booking.endTime!)}",
          ),
          SummaryRowWidget(
              title: 'Booking ID', data: booking.bookingId!.toUpperCase()),
          Gap(32),
          Row(
            children: [
              Expanded(
                child: TMIButton(
                  busy: provider.busy,
                  height: 40,
                  buttonColor: kWhite,
                  textColor: kPrimaryColor,
                  buttonText: 'Cancel',
                  onPressed: () async {
                    await showAppDialog<void>(
                      context,
                      child: CancelBookingConfirmationSheet(
                        cancel: () {
                          Navigator.of(context).pop();
                          ref
                              .read(bookingVM)
                              .cancelBooking(context, booking.bookingId!);
                        },
                      ),
                    );
                  },
                ),
              ),
              const Gap(18),
              Expanded(
                child: TMIButton(
                  busy: provider.busy,
                  height: 40,
                  buttonText: 'Postpone',
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await showAppDialog<void>(context,
                        // dismissible: false,
                        child: RebookSession(booking: booking));
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
