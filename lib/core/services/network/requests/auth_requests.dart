// ignore_for_file: avoid_dynamic_calls, require_trailing_commas

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/exception/failure.dart';
import 'package:mindintrest_user/core/services/firebase/auth.dart';
import 'package:mindintrest_user/core/services/network/network_helper.dart';
import 'package:mindintrest_user/core/services/notification/fcm.dart';

class AuthRequests {
  final NetworkHelper _requestHelper = NetworkHelper();
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Either<Failure, bool>> requestOtp(String phone) async {
    try {
      final res = await _requestHelper.post(
        path: '/users/otp-register',
        data: <String, dynamic>{
          'phone': phone,
          'staging': false
        },
      );
      if (res.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }

  Future<Either<Failure, TmiUser>> updateUser(
      int id, Map<String, dynamic> map) async {
    try {
      final res = await _requestHelper.patch(
        path: '/users/$id',
        data: map,
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

  Future<Either<Failure, TmiUser>> createUser(Map<String, dynamic> map) async {
    try {
      final res = await _requestHelper.post(
        path: '/users/create',
        data: map,
      );
      if (res.statusCode == 201 || res.statusCode == 200) {
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

  Future<Either<Failure, TmiUser?>> verifyOtp(String phone, String otp) async {
    try {
      final res = await _requestHelper.post(
        path: '/users/otp-verify',
        data: <String, dynamic>{
          'otp': otp,
          'phone': phone,
          'staging': false,
          'regToken': await NotificationService.getDeviceToken()
        },
      );
      if (res.statusCode == 200) {
        final token = res.body!['data']['token'].toString();
        final dynamic user = res.body!['data']['user'];
        final successful =
            await FBAuth.signInWithCustomToken(token, _firebaseAuth);

        if (successful) {
          if (user == null) {
            return const Right(null);
          } else {
            return Right(
              TmiUser.fromJson(
                Map<String, dynamic>.from(user as Map),
              ),
            );
          }
        }

        return Left(ApiFailure('Could not sign in'));
      } else {
        return Left(ApiFailure(res.body!['msg'].toString()));
      }
    } on ApiFailure catch (e) {
      return Left(ApiFailure(e.message));
    } catch (e) {
      return Left(ApiFailure('Something went wrong.'));
    }
  }
}
