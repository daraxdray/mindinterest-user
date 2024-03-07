// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mindintrest_user/core/exception/failure.dart';
import 'package:mindintrest_user/core/services/network/network_client.dart';
import 'package:mindintrest_user/core/services/network/response_model.dart';
import 'package:mindintrest_user/utils/logger.dart';

class NetworkHelper {
  final NetworkClient _client = NetworkClient(Dio(),false);
  final NetworkClient _noBaseClient = NetworkClient(Dio(),true);

  Future<ApiResponse> fetch({
    required String path,
    Map<String, dynamic>? params,
    bool noBase = false
  }) async {
    try {
      final response = noBase? await _noBaseClient.get(path) : await _client.get(path, queryParameters: params);

      final apiResponse = ApiResponse()
        ..body = Map<String, dynamic>.from(response.data as Map)
        ..statusCode = response.statusCode;

      return apiResponse;
    } on SocketException {
      throw NetworkFailure(
        'Poor network connection, ensure you have a stable internet connection',
      );
    } on DioError catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw ApiFailure('Poor network connection, please try again');
      } else {
        throw ApiFailure('Server currently under maintenance');
      }
    } catch (e) {
      throw ApiFailure('Something went wrong');
    }
  }

  Future<ApiResponse> delete({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.delete(path, queryParameters: params);

      final apiResponse = ApiResponse()
        ..body = Map<String, dynamic>.from(response.data as Map)
        ..statusCode = response.statusCode;

      return apiResponse;
    } on SocketException {
      throw NetworkFailure(
        'Poor network connection, ensure you have a stable internet connection',
      );
    } on DioError catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw ApiFailure('Poor network connection, please try again');
      } else {
        throw ApiFailure('Server currently under maintenance');
      }
    } catch (e) {
      throw ApiFailure('Something went wrong');
    }
  }

  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    tmiLogger.log(Level.info, data);

    try {
      final response = await _client.post(
        path,
        queryParameters: queryParams,
        data: data,
      );

      tmiLogger.log(Level.info, response.data);

      final apiResponse = ApiResponse()
        ..body = Map<String, dynamic>.from(response.data as Map)
        ..statusCode = response.statusCode;

      return apiResponse;
    } on SocketException {
      throw NetworkFailure(
        'Poor network connection, ensure you have a stable internet connection',
      );
    } on DioError catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw ApiFailure('Poor network connection, please try again');
      } else {
        throw ApiFailure('Server currently under maintenance');
      }
    } catch (e) {
      throw ApiFailure('Something went wrong');
    }
  }

  Future<ApiResponse> put({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _client.put(
        path,
        queryParameters: queryParams,
        data: data,
      );

      final apiResponse = ApiResponse()
        ..body = Map<String, dynamic>.from(response.data as Map)
        ..statusCode = response.statusCode;

      return apiResponse;
    } on SocketException {
      throw NetworkFailure(
        'Poor network connection, ensure you have a stable internet connection',
      );
    } on DioError catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw ApiFailure('Poor network connection, please try again');
      } else {
        throw ApiFailure('Server currently under maintenance');
      }
    } catch (e) {
      throw ApiFailure('Something went wrong');
    }
  }

  Future<ApiResponse> patch({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _client.patch(
        path,
        queryParameters: queryParams,
        data: data,
      );

      final apiResponse = ApiResponse()
        ..body = Map<String, dynamic>.from(response.data as Map)
        ..statusCode = response.statusCode;

      return apiResponse;
    } on SocketException {
      throw NetworkFailure(
        'Poor network connection, ensure you have a stable internet connection',
      );
    } on DioError catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw ApiFailure('Poor network connection, please try again');
      } else {
        throw ApiFailure('Server currently under maintenance');
      }
    } catch (e) {
      throw ApiFailure('Something went wrong');
    }
  }
}
