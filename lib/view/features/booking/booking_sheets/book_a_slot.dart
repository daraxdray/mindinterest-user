import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/utils/utils.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/booking_summary.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';
import 'package:mindintrest_user/view/global_widgets/wrapped_check_boxes.dart';

class BookASlotSheet extends StatefulHookConsumerWidget {
  const BookASlotSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookASlotSheetState();
}

class _BookASlotSheetState extends ConsumerState<BookASlotSheet> {
  TextEditingController dateController = TextEditingController();
  int? dayOfWeek;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = ref.watch(bookingVM);

    return SizedBox(
      height: size.height * .89,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TMIButton(
                enabled: provider.canBook,
                buttonText: 'Continue',
                onPressed: () {
                  Navigator.of(context).pop();
                  showAppBottomSheet<void>(context,
                      dismissible: false, child: const BookingSummaryScreen());
                },
              ),
              Gap(24)
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavHeader(
                showBackButton: false,
                onClosePressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const HeaderSubheaderRow(
                title: 'Book a slot',
                subtitle: 'Select desired time and date for your apointment',
              ),
              const Gap(24),
              TMITextField(
                onTap: () async {
                  final now = DateTime.now();
                  final date = await showDatePicker(
                      context: context,
                      selectableDayPredicate: (day) {
                        if (day.day == now.day &&
                            day.month == now.month &&
                            day.year == now.year) return true;
                        var res = provider.consultantInView.availability!.days!
                            .contains(day.weekday);
                        return res;
                      },
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate: now,
                      firstDate: now,
                      lastDate: now.add(Duration(days: 30)));

                  if (date != null) {
                    dayOfWeek = date.weekday;
                    dateController.text = DateFormatter.formatDateFull(date);
                    provider
                      ..dayOfWeek = dayOfWeek
                      ..bookingDate = date
                      ..notify();
                  }
                },
                hintText: 'Select date',
                labelText: 'Date',
                readOnly: true,
                controller: dateController,
              ),
              const Gap(24),
              Row(
                children: [
                  Text(
                    'Choose time (1hr/Session)',
                    textAlign: TextAlign.left,
                    style: AppStyles.getTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: .2,
                      color: kTitleActiveColor,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Expanded(
                child: WrappedCheckItemPicker(
                  // pickedItems: [],
                  alignment: WrapAlignment.spaceAround,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.spaceBetween,
                  onChanged: (time) {
                    provider
                      ..startTime = time
                      ..notify();
                  },
                  items: getAvailabilityList(
                      provider.consultantInView.availabilityTime!.hours!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> getAvailabilityList(List<int?> hours) {
    return hours.map((hour) {
      return Utils.getTimeFromDigit(hour!);
    }).toList();
  }
}
