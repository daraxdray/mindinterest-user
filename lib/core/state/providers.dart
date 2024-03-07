import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/state/auth/auth_vm.dart';
import 'package:mindintrest_user/core/state/base_vm.dart';
import 'package:mindintrest_user/core/state/market_place/chat_vm.dart';
import 'package:mindintrest_user/core/state/market_place/consultant_listings.dart';
import 'package:mindintrest_user/core/state/themeVM/theme_vm.dart';
import 'package:mindintrest_user/core/state/themeVM/theme_vm_state.dart';
import 'package:mindintrest_user/core/state/user_vm/user_vm.dart';

import 'market_place/booking_vm.dart';
import 'market_place/schedule_listings.dart';

final themeProvider = StateNotifierProvider<AppThemeVM, ThemeState>(
  (ref) {
    return AppThemeVM(ref, themeMode: ThemeMode.system);
  },
  name: 'themeProvider',
);

final userProvider = StateNotifierProvider<UserVM, TmiUser>(
  (_) {
    return UserVM();
  },
);

final baseVM = ChangeNotifierProvider(
  (_) => BaseVM(),
);
final authVM = ChangeNotifierProvider(
  (_) => AuthVM(_),
);

final consultantListingVM = ChangeNotifierProvider(
  (_) => ConsultantListingsVM(_),
);

final scheduleListingVM = ChangeNotifierProvider(
  (_) => ScheduleListingsVM(_),
);

final bookingVM = ChangeNotifierProvider(
  (_) => BookingVM(_),
);

final chatVM = ChangeNotifierProvider(
  (_) => ChatVM(_),
);
