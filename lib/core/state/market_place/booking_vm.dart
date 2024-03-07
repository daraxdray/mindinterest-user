import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';
import 'package:mindintrest_user/core/services/payment/paystack.dart';
import 'package:mindintrest_user/core/state/base_vm.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/utils/alerts.dart';
import 'package:mindintrest_user/utils/logger.dart';

class BookingVM extends BaseVM {
  final MarketPlaceRequests _marketPlaceRequests = MarketPlaceRequests();

  BookingVM(this._reader);
  final Ref _reader;

  Consultant? _currentViewingConsultant;
  Consultant get consultantInView => _currentViewingConsultant!;

  Map<int, TmiUser> reviewUsers = {};

  DateTime? bookingDate;
  int? dayOfWeek;
  String? startTime;

  bool get canBook =>
      bookingDate != null && dayOfWeek != null && startTime != null;

  void setViewingConsultant(Consultant consultant) {
    _currentViewingConsultant = consultant;
  }

  notify() {
    notifyListeners();
  }

  void clearBookinfData() {
    bookingDate = null;
    dayOfWeek = null;
    startTime = null;
    _currentViewingConsultant = null;
  }

  int get24HourTime(String time) {
    if (time.endsWith('pm')) {
      int time = int.tryParse(toNumericString(startTime)) ?? 0;
      if (time == 12) {
        return time;
      }
      return time + 12;
    } else {
      int time = int.tryParse(toNumericString(startTime)) ?? 0;
      return time;
    }
  }

  Future<bool> book(BuildContext context) async {
    final user = _reader.read(userProvider);
    final map = <String, dynamic>{
      "uid": user.id,
      "cid": _currentViewingConsultant!.id,
      "start_time": get24HourTime(startTime!),
      "end_time": get24HourTime(startTime!) + 1,
      "day": dayOfWeek,
      "date": bookingDate?.toIso8601String(),
      "payment_method": "card"
    };

    setBusy(status: true);
    final res = await _marketPlaceRequests.bookConsultant(data: map);

    final value = await res.fold((failure) {
      setBusy(status: false);
      TMIAlerts.showError(context, message: failure.message);
    }, (bookingData) async {
      try {
        tmiLogger.i(bookingData.toJson());
        final paymentRes = await PaystackPayment.chargeCard(context,
            amount: bookingData.amount!,
            ref: bookingData.paymentData!.reference!,
            user: user,
            accessCode: bookingData.paymentData!.accessCode);
        setBusy(status: false);

        if (paymentRes.status == true) {
          setBusy(status: true);
          final verificationSuccess = await _marketPlaceRequests.verifyPayment(
              ref: bookingData.paymentData!.reference!);
          setBusy(status: false);
          return true;
          if (verificationSuccess) {
            return true;
          }
        } else {
          TMIAlerts.showError(context, message: 'Payment was not successful');
          return false;
        }
      } catch (e) {
        setBusy(status: false);
        TMIAlerts.showError(context, message: 'Payment was not successful');
        return false;
      }
      setBusy(status: false);
      return false;
    });
    setBusy(status: false);
    return value ?? false;
  }

  Future<bool> rebook(BuildContext context,
      {String? bid, DateTime? date, int? time, String? day}) async {
    final map = <String, dynamic>{
      "bid": bid,
      "date": date!.toIso8601String(),
      "start_time": get24HourTime(startTime!),
      "end_time": get24HourTime(startTime!) + 1,
      // "day": day,
    };

    setBusy(status: true);
    final res = await _marketPlaceRequests.rebookConsultant(data: map);
    setBusy(status: false);

    final value = await res.fold((failure) {
      TMIAlerts.showError(context, message: failure.message);
    }, (success) async {
      return success;
    });
    return value ?? false;
  }

  void cancelBooking(BuildContext context, String bookingId) async {
    setBusy(status: true);
    final data = {'bid': bookingId};
    final res = await _marketPlaceRequests.cancelBooking(data: data);
    setBusy(status: false);
    res.fold((l) => TMIAlerts.showError(context, message: l.message), (r) {
      Navigator.of(context).pop();
      TMIAlerts.showSuccess(context, message: r);
      _reader.read(consultantListingVM).notify();
    });
  }

  String stringifyTime(int hour) {
    if (hour < 12) {
      return '${hour}am';
    } else
      return '${hour}pm';
  }

  Future<TmiUser> getUser(int uid) async {
    if (reviewUsers[uid] != null) {
      return reviewUsers[uid]!;
    } else {
      final res = await _marketPlaceRequests.fetchUser(uid);
      return res.fold((l) => throw l, (r) {
        reviewUsers[r.id!] = r;
        return r;
      });
    }
  }
}
