import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseRemoteDataSource {
  @protected
  Future<T> post<T>(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      required T Function(dynamic) decoder,
      bool requiredToken = true});

  // @protected
  // Future<T> postImage<T>(
  //     {required String url,
  //       Map<String, dynamic>? body,
  //       Map<String, dynamic>? params,
  //       required T Function(dynamic) decoder,
  //       bool requiredToken = true});

  @protected
  Future<T> get<T>(
      {required String url,
      Map<String, dynamic>? params,
      required T Function(dynamic) decoder,
      bool requiredToken = true});

  // @protected
  // Future<T> delete<T>(
  //     {required String url,
  //       Map<String, dynamic>? params,
  //       required T Function(dynamic) decoder,
  //       bool requiredToken = true});
  //
  // @protected
  // Future<T> put<T>(
  //     {required String url,
  //       Map<String, dynamic>? body,
  //       Map<String, dynamic>? params,
  //       required T Function(dynamic p1) decoder,
  //       bool requiredToken = true});
}

class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  Dio dio;

  BaseRemoteDataSourceImpl({required this.dio});

  // @override
  // Future<T> delete<T>(
  //     {required String url,
  //       Map<String, dynamic>? params,
  //       required T Function(dynamic p1) decoder,
  //       bool requiredToken = true}) async {
  //   try {
  //     if (requiredToken) {
  //       dio.options.headers.addAll({"withToken": true});
  //     }
  //     final response = await dio.delete(
  //       url,
  //       queryParameters: params,
  //     );
  //     try {
  //       return BaseResponse<T>.fromJson(
  //         data: response.data,
  //         decoder: decoder,
  //       );
  //     } catch (e) {
  //       throw const UnexpectedResponseFailure();
  //     }
  //   } on DioError catch (de) {
  //     if (de.error is Failure) {
  //       throw de.error;
  //     } else {
  //       throw const UnknownFailure();
  //     }
  //   }
  // }

  @override
  Future<T> get<T>(
      {required String url,
      Map<String, dynamic>? params,
      required T Function(dynamic p1) decoder,
      bool requiredToken = true}) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      final response = await dio.get(
        url,
        queryParameters: params,
      );

      try {
        return decoder.call(response.data);
      } catch (e) {
        log(e.toString());
        throw Exception('decoding error');
      }
    } on DioError catch (de) {
      log(de.message ?? 'un known error!');
      throw Exception(de.message ?? 'un known error!');
    }
  }

  @override
  Future<T> post<T>(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      required T Function(dynamic p1) decoder,
      bool requiredToken = true}) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      if (headers != null) {
        dio.options.headers = headers;
      }

      final response = await dio.post(url, queryParameters: params, data: body);

      try {
        return decoder.call(response.data);
      } catch (e) {
        log(e.toString());
        throw Exception('decoding error');
      }
    } on DioError catch (de) {
      log(de.message!);
      throw Exception('some thing went wrong!');
    }
  }

  // @override
  // Future<T> postImage<T>(
  //     {required String url,
  //       Map<String, dynamic>? body,
  //       Map<String, dynamic>? params,
  //       required T Function(dynamic p1) decoder,
  //       bool requiredToken = true}) async {
  //   try {
  //     if (requiredToken) {
  //       dio.options.headers.addAll({"withToken": true});
  //     }
  //     final response = await dio.post(url,
  //         queryParameters: params, data: FormData.fromMap(body ?? {}));
  //     try {
  //       return BaseResponse<T>.fromJson(
  //         data: response.data,
  //         decoder: decoder,
  //       );
  //     } catch (e) {
  //       throw const UnexpectedResponseFailure();
  //     }
  //   } on DioError catch (de) {
  //     if (de.error is Failure) {
  //       throw de.error;
  //     } else {
  //       throw const UnknownFailure();
  //     }
  //   }
  // }
  //
  // @override
  // Future<T> put<T>(
  //     {required String url,
  //       Map<String, dynamic>? body,
  //       Map<String, dynamic>? params,
  //       required T Function(dynamic p1) decoder,
  //       bool requiredToken = true}) async {
  //   try {
  //     if (requiredToken) {
  //       dio.options.headers.addAll({"withToken": true});
  //     }
  //
  //     final response = await dio.put(url, queryParameters: params, data: body);
  //
  //     try {
  //       return BaseResponse<T>.fromJson(
  //         data: response.data,
  //         decoder: decoder,
  //       );
  //     } catch (e) {
  //       throw const UnexpectedResponseFailure();
  //     }
  //   } on DioError catch (de) {
  //     if (de.error is Failure) {
  //       throw de.error;
  //     } else {
  //       throw const UnknownFailure();
  //     }
  //   }
  // }
}
