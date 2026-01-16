import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class ApiClient {
  ApiClient._();

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    return dio;
  }
}
