import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio initAppServiceClient(String baseUrl) {
  final options = BaseOptions(
    baseUrl: baseUrl,
    contentType: 'application/json',
    headers: {'Accept':'application/json'},
    connectTimeout: 30000,
    sendTimeout: 30000,
    receiveTimeout: 30000,
  );
  var dio = Dio(options);
  if (kDebugMode) {
    // Local Log
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
  return dio;
}
