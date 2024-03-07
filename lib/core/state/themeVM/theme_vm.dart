import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/constants/storage_keys.dart';

import 'theme_vm_state.dart';

class AppThemeVM extends StateNotifier<ThemeState> {
  AppThemeVM(this._reader, {required this.themeMode})
      : super(ThemeState(themeMode: themeMode));
  final ThemeMode themeMode;
  final  _reader;

  Future<void> setThemeMode(ThemeMode appThemeMode) async {
    const storage = FlutterSecureStorage();

    switch (appThemeMode) {
      case ThemeMode.dark:
        await storage.write(key: kThemeKey, value: 'dark');
        break;
      case ThemeMode.light:
        await storage.write(key: kThemeKey, value: 'light');
        break;
      case ThemeMode.system:
        await storage.write(key: kThemeKey, value: 'system');
        break;
    }
    state = state.copyWith(themeMode: appThemeMode);
  }
}
