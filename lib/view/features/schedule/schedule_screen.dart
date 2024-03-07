import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/features/schedule/past_sessions_widget.dart';
import 'package:mindintrest_user/view/features/schedule/schedule_courosel.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';

class ScheduleScreen extends StatefulHookConsumerWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var scheduleVM = ref.watch(scheduleListingVM);
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: kWhite,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.white,
            width: size.width,
            height: size.height * .32,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(8),
                HeaderSubheaderRow(
                  title: 'Schedule',
                ),
                Expanded(
                  child: FutureBuilder(
                    future: scheduleVM.getFutureBookings(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Booking>?> snapshot) {
                      if (snapshot.hasError ||
                          snapshot.connectionState == ConnectionState.done &&
                              snapshot.data == null) {
                        return SizedBox(
                          height: 100,
                          child: Center(
                            child: Text('Could not fetch bookings'),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return SizedBox(
                            height: 100,
                            child: Center(
                              child: Text('You have no scheduled booking'),
                            ),
                          );
                        } else {
                          return ScheduleCourosel(
                            bookings: snapshot.data!,
                          );
                        }
                      } else {
                        return SizedBox(
                          height: 100,
                          child: Center(
                            child: TMIButtonLoader(
                              color: kPrimaryColor,
                              size: 24,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Gap(24)
              ],
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Past Sessions',
              textAlign: TextAlign.left,
              style: AppStyles.getTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: .2,
                color: kTitleActiveColor,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: FutureBuilder(
              future: scheduleVM.getPastBookings(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Booking>?> snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.done &&
                        snapshot.data == null) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Could not fetch bookings'),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('You have no booking history'),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return PastSessionWidget(
                          booking: snapshot.data![index],
                        );
                      }),
                    );
                  }
                } else {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: TMIButtonLoader(
                        color: kPrimaryColor,
                        size: 24,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
