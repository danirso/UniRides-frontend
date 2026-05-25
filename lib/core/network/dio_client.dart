import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  DioClient() : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://unirides-backend-amfccyfebaapcggu.brazilsouth-01.azurewebsites.net',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          return handler.next(options);
        },
      ),
    );
  }

  Dio get instance => _dio;
}