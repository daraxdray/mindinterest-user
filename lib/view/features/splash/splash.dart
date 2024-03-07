// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/constants/storage_keys.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/services/database/local_storage.dart';
import 'package:mindintrest_user/core/services/firebase/auth.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/core/state/themeVM/theme_vm.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), loadSavedThemeFromDevice);
  }

  dynamic loadSavedThemeFromDevice() async {
    const storage = FlutterSecureStorage();
    var themeMode = ThemeMode.system;

    final value = await storage.read(key: kThemeKey);

    if (value == 'light') {
      themeMode = ThemeMode.light;
    } else if (value == 'dark') {
      themeMode = ThemeMode.dark;
    }

    await ref.read<AppThemeVM>(themeProvider.notifier).setThemeMode(themeMode);

    await popScreen();
  }

  Future<void> popScreen() async {
    final state = FBAuth.checkAuthState();

    switch (state) {
      case AuthState.loggedIn:
        if (await TmiLocalStorage().hasKey(TmiLocalStorage.kUserDataKey)) {
          if (await TmiLocalStorage().getData(TmiLocalStorage.kUserDataKey) ==
              null) {
            GoRouter.of(context).go(RoutePaths.getStarted);
          } else {
            final data =
                await TmiLocalStorage().getData(TmiLocalStorage.kUserDataKey);
            final user = TmiUser.fromJson(
              Map<String, dynamic>.from(json.decode(data!) as Map),
            );
            ref.read(userProvider.notifier).setUser(user);
            context.go(RoutePaths.dashboardIndex);
          }
        } else {
          GoRouter.of(context).go(RoutePaths.onboarding);
        }
        break;
      case AuthState.loggedOut:
        GoRouter.of(context).go(RoutePaths.getStarted);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The Mind Interest',
                style: AppStyles.getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kLabelColor),
              ),
            ],
          ),
          const Gap(42)
        ],
      ),
    );
  }
}
