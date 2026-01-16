import 'package:dio/dio.dart';
import '../../../../../core/api/api_endpoints.dart';

class AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasource(this.dio);

  Future<Response<dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) {
    return dio.post(
      ApiEndpoints.register,
      data: {"name": name.trim(), "email": email.trim(), "password": password},
    );
  }

  Future<Response<dynamic>> login({
    required String email,
    required String password,
  }) {
    return dio.post(
      ApiEndpoints.login,
      data: {"email": email.trim(), "password": password},
    );
  }
}
