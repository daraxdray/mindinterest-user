import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/currency_fomatter.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/booking_success.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/summary_row.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class BookingSummaryScreen extends HookConsumerWidget {
  const BookingSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(bookingVM);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .6,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        child: Column(
          children: [
            NavHeader(
              showBackButton: false,
              onClosePressed: () {
                Navigator.of(context).pop();
              },
            ),
            const HeaderSubheaderRow(
              title: 'Confirm Booking',
              subtitle: 'Please confirm your session details ',
            ),
            const Gap(36),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SummaryRowWidget(
                        title: 'Therapist',
                        data: provider.consultantInView.name!),
                    SummaryRowWidget(
                        title: 'Date',
                        data:
                            DateFormatter.formatDateFull(provider.bookingDate)),
                    SummaryRowWidget(title: 'Time', data: provider.startTime!),
                    SummaryRowWidget(
                        title: 'cost',
                        data: CurrencyFormatter.format(
                          provider.consultantInView.hourlyRate!.toDouble(),
                          currencyPrefix: true,
                        )),
                  ],
                ),
              ),
            ),
            TMIButton(
              busy: provider.busy,
              buttonText: 'Proceed to Payment',
              onPressed: () async {
                final success = await ref.read(bookingVM).book(context);
                if (success) {
                  showAppBottomSheet<void>(
                    context,
                    dismissible: false,
                    child: const BookingSuccessSheet(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
