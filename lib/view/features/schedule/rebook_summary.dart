import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/currency_fomatter.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/utils/utils.dart';
import 'package:mindintrest_user/view/features/schedule/rebook_success.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/summary_row.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class RebookSummaryScreen extends HookConsumerWidget {
  const RebookSummaryScreen(
      {Key? key,
      required this.bookingDate,
      required this.bookingTime,
      required this.cost,
      required this.bookingId,
      required this.therapistName})
      : super(key: key);
  final String therapistName;
  final int bookingTime;
  final DateTime bookingDate;
  final int cost;
  final String bookingId;
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
              title: 'Confirm Re-booking',
              subtitle: 'Please confirm your session details ',
            ),
            const Gap(36),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SummaryRowWidget(title: 'Therapist', data: therapistName),
                    SummaryRowWidget(
                        title: 'Date',
                        data: DateFormatter.formatDateFull(bookingDate)),
                    SummaryRowWidget(
                        title: 'Time',
                        data: Utils.getTimeFromDigit(bookingTime)),
                    SummaryRowWidget(
                        title: 'cost',
                        data: CurrencyFormatter.format(
                          cost.toDouble(),
                          currencyPrefix: true,
                        )),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TMIButton(
                    buttonColor: kWhite,
                    height: 40,
                    busy: provider.busy,
                    buttonText: 'Cancel',
                    fontSize: 14,
                    textColor: kPrimaryColor,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Gap(12),
                Expanded(
                  child: TMIButton(
                    height: 40,
                    busy: provider.busy,
                    buttonText: 'Proceed',
                    fontSize: 14,
                    onPressed: () async {
                      final success = await ref.read(bookingVM).rebook(context,
                          bid: bookingId, date: bookingDate, time: bookingTime);
                      if (success) {
                        Navigator.of(context).pop();
                        showAppBottomSheet<void>(
                          context,
                          dismissible: false,
                          child: RebookSuccessSheet(
                            bookingDate: bookingDate,
                            consultantname: therapistName,
                            startTime: Utils.getTimeFromDigit(bookingTime),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
