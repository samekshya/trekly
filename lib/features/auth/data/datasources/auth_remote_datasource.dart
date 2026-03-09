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

  // calls POST /api/auth/forgot-password
  Future<void> forgotPassword(String email) async {
    await _dio.post(
      ApiEndpoints.forgotPassword,
      data: {'email': email.trim()},
    );
  }

  Future<Map<String, dynamic>> getMe() async {
    final res = await _dio.get(ApiEndpoints.me);
    return res.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateProfile(
    String id,
    Map<String, dynamic> data,
  ) async {
    final res = await _dio.put(
      ApiEndpoints.updateProfile(id),
      data: data,
    );
    return res.data as Map<String, dynamic>;
  }
}
