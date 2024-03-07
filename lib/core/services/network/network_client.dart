// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mindintrest_user/app/flavor_config.dart';
import 'package:mindintrest_user/core/services/network/dio_logger.dart';

class NetworkClient {
  NetworkClient(this._dio,this.isNoBase) {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.options = BaseOptions(
      baseUrl: isNoBase?'':EnvCredentials.kUrlHost,
      connectTimeout: Duration(seconds:10000),
      receiveTimeout:  Duration(seconds:10000),
      sendTimeout:  Duration(seconds:10000),
      validateStatus: (status) {
        return status! < 500;
      },
    );
  }

  final Dio _dio;
  final bool isNoBase;
  Future<Map<String, dynamic>> _getHeader() async {
    return <String, dynamic>{
      'content-type': 'application/json',
      'accept': 'application/json',
      'Authorization':
          'Bearer ${await FirebaseAuth.instance.currentUser?.getIdToken()}'
    };
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
      options: Options(headers: await _getHeader()),
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: await _getHeader()),
    );
  }

  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.put<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: await _getHeader()),
    );
  }

  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.patch<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: await _getHeader()),
    );
  }

  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.delete<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: await _getHeader()),
    );
  }

  Future<Response<dynamic>> postFormData(
    String path, {
    FormData? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.post<dynamic>(
      path,
      data: formData,
      queryParameters: queryParameters,
      options: Options(
        headers: <String, dynamic>{
          'content-type': 'multipart/form-data',
          'accept': 'multipart/form-data',
          'Authorization':
              'Bearer ${await FirebaseAuth.instance.currentUser!.getIdToken()}'
        },
      ),
    );
  }
}
