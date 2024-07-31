
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';

abstract interface class IServiceWrapper {
  abstract final Dio dio;
  abstract final ApiService apiService;

  Future<String> request(
    String path, {
    Method method = Method.get,
    Map<String, Object>? body,
  });
}

class CurrencyWrapper implements IServiceWrapper {
  CurrencyWrapper({required this.dio}) : apiService = ApiService(dio);

  @override
  @visibleForTesting
  @protected
  final ApiService apiService;

  @override
  @visibleForTesting
  @protected
  final Dio dio;

  @override
  Future<String> request(
    String path, {
    Method method = Method.get,
    Map<String, Object>? body,
  }) =>
      apiService.request(
        path,
        method: method,
        body: body,
      );
}
