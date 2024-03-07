// ignore_for_file: avoid_positional_boolean_parameters


import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';
import 'package:mindintrest_user/core/state/base_vm.dart';
import 'package:mindintrest_user/core/state/providers.dart';

class ScheduleListingsVM extends BaseVM {
  ScheduleListingsVM(this._ref);
  final Ref _ref;
  bool futureBookingsLoading = false;
  bool pastBookingsLoading = false;

  final _api = MarketPlaceRequests();
  List<Booking>? pastBookings;
  List<Booking>? futureBookings;

  void setPastBookingLoading(bool value) {
    pastBookingsLoading = value;
    // notifyListeners();
  }

  void setFutureBookingLoading(bool value) {
    futureBookingsLoading = value;
    // notifyListeners();
  }

  void notify() {
    setBusy(status: false);
  }

  Future<List<Booking>?> getPastBookings() async {
    setPastBookingLoading(true);
    final result = await _api
        .getBookings(userID: _ref.read(userProvider).id!, status:"completed");
    setPastBookingLoading(false);

    return result.fold((l) => null, (r) {
      pastBookings = r;
      setPastBookingLoading(false);
      return r;
    });
  }

  Future<String?> getAccessToken(int? consultantId) async {
    // setFutureBookingLoading(true);
    final res1 = await _api
        .getAccessToken(userId: _ref.read(userProvider).id!, roomName: "TMI-$consultantId${_ref.read(userProvider).id!}");

    var results = res1.fold((l) {
      return null;
    }, (r) {
      return r;
    });

    return results;
  }

  Future<List<Booking>?> getFutureBookings() async {
    setFutureBookingLoading(true);
    final res1 = await _api
        .getBookings(userID: _ref.read(userProvider).id!, status: "pending");
    final res2 = await _api.getActiveBooking(userID: _ref.read(userProvider).id!);

    var results = res1.fold((l) {
      return null;
    }, (r) {
      return r;
    });

    var booking = res2.fold((l) => null, (r) => r);

    if (results == null && booking == null) {
      setFutureBookingLoading(false);
      return futureBookings;
    }
    if (results == null && booking != null) {
      futureBookings = [booking];
      setFutureBookingLoading(false);
      return futureBookings;
    } else if (results!.isEmpty && booking == null) {
      futureBookings = [];
    } else if (results.isNotEmpty && booking == null) {
      futureBookings = results;
    } else if (results.isNotEmpty && booking != null) {
      futureBookings = [booking, ...results];
    }

    setFutureBookingLoading(false);
    return futureBookings;
  }
}
