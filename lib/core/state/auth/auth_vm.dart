// ignore_for_file: use_setters_to_change_properties, use_build_context_synchronously,

import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';
import 'package:mindintrest_user/core/constants/enums.dart';
import 'package:mindintrest_user/core/services/database/local_storage.dart';
import 'package:mindintrest_user/core/services/firebase/file_upload.dart';
import 'package:mindintrest_user/core/services/network/requests/auth_requests.dart';
import 'package:mindintrest_user/core/state/base_vm.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/alerts.dart';
import 'package:mindintrest_user/utils/utils.dart';

class AuthVM extends BaseVM {
  AuthVM(this._ref);
  final Ref _ref;
  final _api = AuthRequests();

//Registration Details
  Gender? gender;
  AgeRange? ageRange;
  ReferalMedium? referalMedium;
  NeedToTalk? needToTalk;
  RelationshipStatus? relationshipStatus;
  RelationshipStatusDuration? relationshipStatusDuration;
  ParentStatus? parentStatus;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void notify() {
    notifyListeners();
  }

  String _phoneNumber = '';

  String get phone => _phoneNumber;

  void savePhone(String data) {
    _phoneNumber = data;
    notifyListeners();
  }

  Future<void> requestOTP(BuildContext context) async {
    setBusy(status: true);
    final res = await _api
        .requestOtp(Utils.cleanPhoneNumberWithStatusCode(phone: phone));
    setBusy(status: false);
    res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
      return;
    }, (success) {
      context.push(RoutePaths.verifyOtp);
    });
  }

  Future<void> verifyOTP(BuildContext context, String otp) async {
    setBusy(status: true);
    final res = await _api.verifyOtp(
      Utils.cleanPhoneNumberWithStatusCode(phone: phone),
      otp,
    );
    setBusy(status: false);
    res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
    }, (user) {
      if (user == null) {
        //No profile data, send the to onboard
        context.push(RoutePaths.onboarding);
      } else {
        TmiLocalStorage().putData(
          key: TmiLocalStorage.kUserDataKey,
          value: json.encode(
            user.toJson(),
          ),
        );
        _ref.read(userProvider.notifier).setUser(user);
        context.go(RoutePaths.dashboardIndex);
      }
    });
  }

  Future<void> updateProfile(
    BuildContext context, {
    required String fName,
    required String lName,
  }) async {
    final map = {
      'name': '${lName.trim()} ${fName.trim()}',
    };
    setBusy(status: true);
    final res = await _api.updateUser(_ref.read(userProvider).id!, map);
    setBusy(status: false);
    res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
    }, (res) {
      final user = _ref.read(userProvider).copyWith(name: res.name);
      TmiLocalStorage().putData(
        key: TmiLocalStorage.kUserDataKey,
        value: json.encode(
          user.toJson(),
        ),
      );
      _ref.read(userProvider.notifier).setUser(user);
      TMIAlerts.showSuccess(context, message: 'Changes saved!');
    });
  }

  Future<void> updateAvatar(BuildContext context, {required String url}) async {
    final map = {
      'profile_img': url,
    };
    setBusy(status: true);
    final res = await _api.updateUser(_ref.read(userProvider).id!, map);
    setBusy(status: false);
    res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
    }, (res) {
      final user = _ref.read(userProvider).copyWith(profileImg: url);
      TmiLocalStorage().putData(
        key: TmiLocalStorage.kUserDataKey,
        value: json.encode(
          user.toJson(),
        ),
      );
      _ref.read(userProvider.notifier).setUser(user);
      TMIAlerts.showSuccess(context, message: 'Changes saved!');
    });
  }

  void initializeProfilePersonalization() {
    final user = _ref.read(userProvider);

    ageRange = EnumToString.fromString(AgeRange.values, user.ageRange!);
    referalMedium = EnumToString.fromString(
      ReferalMedium.values,
      user.referer!,
      camelCase: true,
    );
    needToTalk = EnumToString.fromString(
      NeedToTalk.values,
      user.needToTalk!,
      camelCase: true,
    );
    relationshipStatus = EnumToString.fromString(
      RelationshipStatus.values,
      user.relationshipStatus!,
    );
    relationshipStatusDuration = EnumToString.fromString(
      RelationshipStatusDuration.values,
      user.relationshipDuration!,
      camelCase: true,
    );
    parentStatus =
        EnumToString.fromString(ParentStatus.values, user.parentalStatus!);
  }

  void cleanRegistrationData() {
    gender = null;
    ageRange = null;
    referalMedium = null;
    needToTalk = null;
    relationshipStatus = null;
    relationshipStatusDuration = null;
    parentStatus = null;
    _phoneNumber = '';
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  Future<void> personaliseProfile(BuildContext context) async {
    final map = {
      'age_range': EnumToString.convertToString(ageRange),
      'need_to_talk': EnumToString.convertToString(needToTalk, camelCase: true),
      'relationship_status': EnumToString.convertToString(relationshipStatus),
      'relationship_duration': EnumToString.convertToString(
        relationshipStatusDuration,
        camelCase: true,
      ),
      'parental_status': EnumToString.convertToString(parentStatus),
    };
    setBusy(status: true);
    final res = await _api.updateUser(_ref.read(userProvider).id!, map);
    setBusy(status: false);
    res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
    }, (ref) {
      final user = _ref.read(userProvider).copyWith(
        ageRange: ref.ageRange,
        needToTalk: ref.needToTalk,
        relationshipStatus: ref.relationshipStatus,
        relationshipDuration: ref.relationshipDuration,
        parentalStatus: ref.parentalStatus,
      );
      TmiLocalStorage().putData(
        key: TmiLocalStorage.kUserDataKey,
        value: json.encode(
          user.toJson(),
        ),
      );
      _ref.read(userProvider.notifier).setUser(user);
      TMIAlerts.showSuccess(context, message: 'Changes saved!');
    });
  }

  Future<void> completeSignUp(BuildContext context) async {
    final map = {
      'device': Platform.isAndroid
          ? 'Android'
          : Platform.isIOS
              ? 'IOS'
              : 'Unknown',
      'name':
          '${lastNameController.text.trim()} ${firstNameController.text.trim()}',
      'phone': Utils.cleanPhoneNumberWithStatusCode(phone: phone),
      'gender': EnumToString.convertToString(gender, camelCase: true),
      'age_range': EnumToString.convertToString(ageRange),
      'referer': EnumToString.convertToString(referalMedium, camelCase: true),
      'need_to_talk': EnumToString.convertToString(needToTalk, camelCase: true),
      'relationship_status': EnumToString.convertToString(relationshipStatus),
      'relationship_duration': EnumToString.convertToString(
        relationshipStatusDuration,
        camelCase: true,
      ),
      'parental_status': EnumToString.convertToString(parentStatus),
      'profile_img': ''
    };
    setBusy(status: true);
    final res = await _api.createUser(map);
    setBusy(status: false);
    res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
    }, (user) {
      TmiLocalStorage().putData(
        key: TmiLocalStorage.kUserDataKey,
        value: json.encode(
          user.toJson(),
        ),
      );
      _ref.read(userProvider.notifier).setUser(user);
      cleanRegistrationData();
      // TMIAlerts.showSuccess(context, message: 'Changes saved!');
      context.go(RoutePaths.dashboardIndex);
    });
  }

  Future<void> uploadProfileImage(BuildContext context, File file) async {
    setBusy(status: true);
    final result = await FileUploader().uploadFile(file, 'profile_picture');
    return result.fold((l) async {
      await updateAvatar(context, url: l);
      // return true;
    }, (r) {
      TMIAlerts.showError(context, message: r.message);
      setBusy(status: false);
      // return false;
    });
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await TmiLocalStorage().clearStorage();
    context.go(RoutePaths.getStarted);
  }
}
