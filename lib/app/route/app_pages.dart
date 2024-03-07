import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/view/features/auth/login.dart';
import 'package:mindintrest_user/view/features/auth/verify_otp.dart';
import 'package:mindintrest_user/view/features/booking/rate_consultant.dart';
import 'package:mindintrest_user/view/features/booking/therapist_detail.dart';
import 'package:mindintrest_user/view/features/chat/conversation_screen.dart';
import 'package:mindintrest_user/view/features/dashboard_index.dart';
import 'package:mindintrest_user/view/features/onboarding/get_started.dart';
import 'package:mindintrest_user/view/features/onboarding/onboarding_complete.dart';
import 'package:mindintrest_user/view/features/onboarding/onboarding_index.dart';
import 'package:mindintrest_user/view/features/profile/edit_profile.dart';
import 'package:mindintrest_user/view/features/profile/personalize_index.dart';

import 'package:mindintrest_user/view/features/splash/splash.dart';

import '../../view/browser.dart';
import '../../view/browser2.dart';

class RoutePaths {
  static const splash = '/';
  static const home = '/home';
  static const getStarted = '/get-started';
  static const login = '/login';
  static const onboarding = '/onbaording';
  static const dashboardIndex = '/dashboard-index';
  static const onBoardingSuccess = '/onboarding-success';
  static const verifyOtp = '/verify-otp';
  static const therapistDetail = '/therapist-detail';
  static const conversationScreen = '/conversation-screen';
  static const editProfileScreen = '/edit-profile';
  static const personaliseProfileScreen = '/personalise-profile';
  static const rateSession = '/rate-session';
  static const call = '/video-audio-call';
  static const call2 = '/video-audio-call2';
}

class AppRoutes {
  static final routes = [
    GoRoute(
      path: RoutePaths.splash,
      name: RoutePaths.splash,
      pageBuilder: (context, state) {
        return MaterialPage<SplashScreen>(
          key: state.pageKey,
          child: const SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      name: RoutePaths.onboarding,
      pageBuilder: (context, state) {
        return MaterialPage<OnboardingIndex>(
          key: state.pageKey,
          child: const OnboardingIndex(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.personaliseProfileScreen,
      name: RoutePaths.personaliseProfileScreen,
      pageBuilder: (context, state) {
        return MaterialPage<PersonalizeIndexScreen>(
          key: state.pageKey,
          child: const PersonalizeIndexScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.editProfileScreen,
      name: RoutePaths.editProfileScreen,
      pageBuilder: (context, state) {
        return MaterialPage<EditProfileScreen>(
          key: state.pageKey,
          child: const EditProfileScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.conversationScreen,
      name: RoutePaths.conversationScreen,
      pageBuilder: (context, state) {
        final int cid = int.tryParse(state.uri.queryParameters['cid']!)!;
        final String bid = state.uri.queryParameters['bid']!;
        final String meetLink = "${state.uri.queryParameters['meetLink']}";
        return MaterialPage<ConversationScreen>(
          key: state.pageKey,
          child: ConversationScreen(
            cid: cid,
            bookingId: bid,
            meetLink:meetLink
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.call,
      name: RoutePaths.call,
      pageBuilder: (context, state) {

        final String url = state.uri.queryParameters['url']!;
        final String cid = state.uri.queryParameters['cid']!;
        final String bid = state.uri.queryParameters['bid']!;
        return MaterialPage<BrowserScreen>(
          key: state.pageKey,
          child: BrowserScreen(
           url: url,
            cid: cid,
              bookingId: bid,
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.call2,
      name: RoutePaths.call2,
      pageBuilder: (context, state) {

        final String url = state.uri.queryParameters['url']!;
        final String cid = state.uri.queryParameters['cid']!;
        final String bid = state.uri.queryParameters['bid']!;
        return MaterialPage<BrowserScreen>(
          key: state.pageKey,
          child: WebViewExample(
           url: url,
            cid: cid,
              bookingId: bid,
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.rateSession,
      name: RoutePaths.rateSession,
      pageBuilder: (context, state) {
        final int cid = int.tryParse(state.uri.queryParameters['cid']!)!;
        final String bid = state.uri.queryParameters['bid']!;
        return MaterialPage<RateConsultantScreen>(
          key: state.pageKey,
          child: RateConsultantScreen(
            cid: cid,
            bookingId: bid,
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.dashboardIndex,
      name: RoutePaths.dashboardIndex,
      pageBuilder: (context, state) {
        return MaterialPage<DashboardIndexScreen>(
          key: state.pageKey,
          child: const DashboardIndexScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.therapistDetail,
      name: RoutePaths.therapistDetail,
      pageBuilder: (context, state) {
        final consultant = state.extra as Consultant;
        return MaterialPage<TherapistDetailScreen>(
          key: state.pageKey,
          child: TherapistDetailScreen(
            consultant: consultant,
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.onBoardingSuccess,
      name: RoutePaths.onBoardingSuccess,
      pageBuilder: (context, state) {
        return MaterialPage<OnboardingSuccessScreen>(
          key: state.pageKey,
          child: const OnboardingSuccessScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.getStarted,
      name: RoutePaths.getStarted,
      pageBuilder: (context, state) {
        return MaterialPage<GetStartedScreen>(
          key: state.pageKey,
          child: const GetStartedScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.verifyOtp,
      name: RoutePaths.verifyOtp,
      pageBuilder: (context, state) {
        return MaterialPage<VerifyOTPScreen>(
          key: state.pageKey,
          child: const VerifyOTPScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.login,
      name: RoutePaths.login,
      pageBuilder: (context, state) {
        return MaterialPage<LoginScreen>(
          key: state.pageKey,
          child: const LoginScreen(),
        );
      },
    ),
  ];
}
