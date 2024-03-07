import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';
import 'package:mindintrest_user/utils/alerts.dart';
import 'package:mindintrest_user/utils/date_fomatter.dart';
import 'package:mindintrest_user/utils/utils.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';
import 'package:mindintrest_user/view/global_widgets/wrapped_check_boxes.dart';

import 'rebook_summary.dart';

class RebookSession extends StatefulHookConsumerWidget {
  const RebookSession({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookASlotSheetState();
}

class _BookASlotSheetState extends ConsumerState<RebookSession> {
  TextEditingController dateController = TextEditingController();
  MarketPlaceRequests _api = MarketPlaceRequests();
  int? dayOfWeek;
  Consultant? consultant;
  bool _isLoading = true;
  bool _buttonLoading = false;
  int? startTime;
  bool _canBook = false;
  int? _dayOfWeek;
  DateTime? _bookingDate;
  String? _time;

  void _fetchConsultant() async {
    final res = await _api.fetchConsultant(widget.booking.cid!);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      res.fold((l) {
        TMIAlerts.showError(context, message: l.message);
      }, (r) {
        setState(() {
          consultant = r;
        });
      });
    }
  }

  void _rebook() async {
    final res = await _api.rebookConsultant(data: {
      "bid": widget.booking.bookingId,
      "date": '',
      "start_time": startTime,
      "end_time": startTime! + 1,
    });
    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      res.fold((l) {
        TMIAlerts.showError(context, message: l.message);
      }, (r) {
        if (r == true) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void initState() {
    _fetchConsultant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .70,
      child: _isLoading
          ? Scaffold(
              body: Center(
                child: TMIButtonLoader(
                  color: kPrimaryColor,
                  size: 18,
                ),
              ),
            )
          : consultant == null
              ? Scaffold(
                  body: Center(child: Text('Could not fetch data')),
                )
              : Scaffold(
                  bottomNavigationBar: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TMIButton(
                        enabled: _bookingDate != null &&
                            _dayOfWeek != null &&
                            _time != null,
                        buttonText: 'Postpone',
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await showAppDialog<void>(context,
                              dismissible: false,
                              child: RebookSummaryScreen(
                                bookingDate: _bookingDate!,
                                bookingId: widget.booking.bookingId!,
                                bookingTime: startTime!,
                                cost: widget.booking.cost!,
                                therapistName: consultant!.name!,
                              ));
                        },
                      ),
                      Gap(24)
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
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
                          title: 'Reschedule',
                          subtitle: '',
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
                                  return consultant!.availability!.days!
                                      .contains(day.weekday);
                                },
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                initialDate: now,
                                firstDate: now,
                                lastDate: now.add(Duration(days: 30)));

                            if (date != null) {
                              dayOfWeek = date.weekday;
                              dateController.text =
                                  DateFormatter.formatDateFull(date);
                              _dayOfWeek = dayOfWeek;
                              _bookingDate = date;
                              setState(() {});
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
                              print(toNumericString(time));
                              setState(() {
                                _time = time;
                                startTime = int.tryParse(toNumericString(time));
                              });
                            },
                            items: getAvailabilityList(
                                consultant!.availabilityTime!.hours!),
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
