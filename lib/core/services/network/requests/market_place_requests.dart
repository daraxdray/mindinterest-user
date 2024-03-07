
import 'package:dartz/dartz.dart';
import 'package:mindintrest_user/core/data_models/booking_model.dart';
import 'package:mindintrest_user/core/data_models/booking_response_model.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/data_models/rating_data.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/services/network/network_helper.dart';

import '../../../exception/failure.dart';

class MarketPlaceRequests {
  final NetworkHelper _requestHelper = NetworkHelper();

  Future<Either<Failure, List<Consultant>>> getReccomendedConsultants() async {
    try {
      final res = await _requestHelper.fetch(
        path: '/market/recommended',
      );
      if (res.statusCode == 200) {
        final list = List<Consultant>.from(res.body!['data']["consultants"]
            .map((x) => Consultant.fromJson(x)));
        list.removeWhere((item) => item.hourlyRate == null);

        return Right(list);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, List<Consultant>>> getFeaturedConsultants() async {
    try {
      final res = await _requestHelper.fetch(
        path: '/market/featured',
      );
      print(res.body);
      if (res.statusCode == 200) {
        final list = List<Consultant>.from(res.body!['data']["consultants"]
            .map((x) => Consultant.fromJson(x)));
        list.removeWhere((item) => item.hourlyRate == null);
        return Right(list);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, List<Booking>>> getBookings(
      {required int userID, required String status}) async {
    try {
      final res = await _requestHelper.fetch(
        // path: '/market/user-filter-status/$userID',
        path: '/market/user-bookings/$userID',
        params: <String, dynamic>{'status': status},
      );
      if (res.statusCode == 200) {

        final list = List<Booking>.from(
            res.body!['data']["bookings"].map((x) => Booking.fromJson(x)));
        return Right(list);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, Booking>> getActiveBooking(
      {required int userID}) async {
    try {
      final res = await _requestHelper.post(
        path: '/market/in-progress/$userID',
      );
      if (res.statusCode == 200) {
        final booking = res.body!['data']["updated"];

        if (booking == null) {
          return Left(ApiFailure('No active booking'));
        } else if ((booking as Map).isEmpty) {
          return Left(ApiFailure('No active booking'));
        }

        return Right(
            Booking.fromJson(Map<String, dynamic>.from(booking)));
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, BookingResponseModel>> bookConsultant(
      {required Map<String, dynamic> data}) async {
    try {
      final res = await _requestHelper.post(path: '/market/book', data: data);
      if (res.statusCode == 200) {
        final dynamic data = res.body!['data'];
        return Right(
          BookingResponseModel.fromJson(
            Map<String, dynamic>.from(data as Map),
          ),
        );
      } else {
        return Left(ApiFailure(
            (res.body!['msg'] ?? 'Could not proccess booking').toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, bool>> rebookConsultant(
      {required Map<String, dynamic> data}) async {
    try {
      final res = await _requestHelper.post(
          path: '/market/postpone-booking', data: data);
      if (res.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<bool> verifyPayment({required String ref}) async {
    try {
      final res = await _requestHelper
          .fetch(path: '/market/payment/verify', params: {'reference': ref});
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on ApiFailure {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Either<Failure, String>> cancelBooking(
      {required Map<String, dynamic> data}) async {
    try {
      final res =
          await _requestHelper.post(path: '/market/cancel-booking', data: data);
      if (res.statusCode == 200) {
        final dynamic data = res.body!['data'];
        return Right(data['msg']);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, bool>> rateSession(int uid,
      {required Map<String, dynamic> data}) async {
    try {
      final res =
          await _requestHelper.post(path: '/market/rate/$uid', data: data);
      if (res.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, Consultant>> fetchConsultant(int cid) async {
    try {
      final res = await _requestHelper.fetch(
        path: '/consultants/$cid',
      );

      if (res.statusCode == 200) {
        final dynamic user = res.body!['data']['consultant'];
        return Right(
          Consultant.fromJson(
            Map<String, dynamic>.from(user as Map),
          ),
        );
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, TmiUser>> fetchUser(int uid) async {
    try {
      final res = await _requestHelper.fetch(
        path: '/users/$uid',
      );

      if (res.statusCode == 200) {
        final dynamic user = res.body!['data']['user'];
        return Right(
          TmiUser.fromJson(
            Map<String, dynamic>.from(user as Map),
          ),
        );
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, List<ConsultantsRatingsReviews?>>> getReviews(
      {required int consultantId}) async {
    try {
      final res = await _requestHelper.fetch(
        path: '/consultants/reviews/$consultantId',
      );
      if (res.statusCode == 200) {
        final data = ConsultantsRatings.fromJson(
            res.body!['data'] as Map<String, dynamic>);
        var list = data.reviews;
        list!.removeWhere((x) => x!.review == null);
        return Right(data.reviews!);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, String?>> getAccessToken(
      {required int userId, required String roomName}) async {
    try {
      final res = await _requestHelper.fetch(
        // path: '/market/user-filter-status/$userID',
        path: 'https://twiliochatroomaccesstoken-4186.twil.io/access_token?user=$userId',
        noBase: true
      );
      if (res.statusCode == 200) {
        final response = res.body!['accessToken'];
        return Right(response);
      } else {
        return Left(ApiFailure(res.body!['msg'] ?? "Error"));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure("${e.message}"));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

}
