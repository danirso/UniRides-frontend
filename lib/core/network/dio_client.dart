import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  DioClient() {
    const baseUrl = String.fromEnvironment(
      'API_URL',
      defaultValue: 'http://127.0.0.1:8000',
    );
    debugPrint('Dio baseUrl: $baseUrl');
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          debugPrint('DioError: ${error.message}');
          debugPrint('DioError URL: ${error.requestOptions.baseUrl}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get instance => _dio;
}