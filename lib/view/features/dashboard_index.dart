// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/view/features/chat/chat_screen.dart';
import 'package:mindintrest_user/view/features/profile/profile_screen.dart';
import 'package:mindintrest_user/view/features/schedule/schedule_screen.dart';

import 'home/home_screen.dart';

class DashboardIndexScreen extends StatefulWidget {
  const DashboardIndexScreen({Key? key}) : super(key: key);

  @override
  _DashboardIndexScreenState createState() => _DashboardIndexScreenState();
}

class _DashboardIndexScreenState extends State<DashboardIndexScreen> {
  int _currentIndex = 0;
  bool _hasShownLinkAccountSplash = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kPlaceHolderColor,
        selectedLabelStyle: AppStyles.getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
        ),
        unselectedLabelStyle: AppStyles.getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: kPlaceHolderColor,
        ),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 23,
                width: 23,
                child: Image.asset(
                  'assets/images/home.png',
                  color: _currentIndex == 0 ? kPrimaryColor : kPlaceHolderColor,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 23,
                width: 23,
                child: Image.asset(
                  'assets/images/calender.png',
                  color: _currentIndex == 1 ? kPrimaryColor : kPlaceHolderColor,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 23,
                width: 23,
                child: Image.asset(
                  'assets/images/comment.png',
                  color: _currentIndex == 2 ? kPrimaryColor : kPlaceHolderColor,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 23,
                width: 23,
                child: Image.asset(
                  'assets/images/profile.png',
                  color: _currentIndex == 3 ? kPrimaryColor : kPlaceHolderColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ScheduleScreen();
      case 2:
        return const ChatScreen();
      case 3:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}
