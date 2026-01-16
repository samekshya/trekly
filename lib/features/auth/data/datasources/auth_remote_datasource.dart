import 'package:dio/dio.dart';
import '../../../../core/api/api_endpoints.dart';

class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _dio.post(
      ApiEndpoints.login,
      data: {"email": email.trim(), "password": password},
    );

    if (res.data is Map<String, dynamic>) {
      return res.data as Map<String, dynamic>;
    }
    return {"data": res.data};
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _dio.post(
      ApiEndpoints.register,
      data: {"name": name.trim(), "email": email.trim(), "password": password},
    );

    if (res.data is Map<String, dynamic>) {
      return res.data as Map<String, dynamic>;
    }
    return {"data": res.data};
  }
}
