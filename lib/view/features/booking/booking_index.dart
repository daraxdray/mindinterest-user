import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/book_a_slot.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/booking_expectation.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/booking_reason.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/current_feeling.dart';
import 'package:mindintrest_user/view/features/booking/booking_sheets/sleeping_habit.dart';
import 'package:mindintrest_user/view/global_widgets/dialogs.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_button.dart';

class BookingIndex extends StatefulWidget {
  const BookingIndex({Key? key}) : super(key: key);

  @override
  _BookingIndexState createState() => _BookingIndexState();
}

class _BookingIndexState extends State<BookingIndex> {
  late PageController _pageController;
  late int _currentIndex;

  late List<Widget> _screens;

  @override
  void initState() {
    _screens = const [
      TherapyResonScreen(),
      BookingExpectationScreen(),
      CurrentFeelingScreen(),
      SleepingHabitScreen()
    ];
    _pageController = PageController();
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .6,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          child: Column(
            children: [
              const Gap(14),
              NavHeader(
                onBackPressed: () {
                  if (_currentIndex == 0) {
                    context.pop();
                  } else {
                    _pageController.animateToPage(_currentIndex - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  }
                },
                showBackButton: _currentIndex > 0,
                title: '${_currentIndex + 1} of ${_screens.length}',
              ),
              const Gap(24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    controller: _pageController,
                    children: _screens,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 2, 24, 24),
              child: TMIButton(
                buttonText: 'Continue',
                onPressed: () {
                  if (_currentIndex == _screens.length - 1) {
                    Navigator.of(context).pop();
                    showAppBottomSheet<void>(
                      context,
                      dismissible: false,
                      child: const BookASlotSheet(),
                    );
                  } else {
                    _pageController.animateToPage(
                      _currentIndex + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),
            ),
            const Gap(24)
          ],
        ),
      ),
    );
  }

  bool showBackButton() {
    return true;
  }

  bool showCloseButton() {
    return true;
  }
}
