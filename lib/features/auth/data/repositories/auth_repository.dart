import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepository {
  AuthRepository(this.remote);

  final AuthRemoteDatasource remote;

  // ====== Your new API methods (we use these) ======
  Future<dynamic> register(String name, String email, String password) async {
    try {
      final res = await remote.register(
        name: name,
        email: email,
        password: password,
      );
      return res.data;
    } on DioException catch (e) {
      throw _readableDioError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final res = await remote.login(email: email, password: password);

      // Try to save token if backend returns it
      final data = res.data;
      final token = _extractToken(data);
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }

      return data;
    } on DioException catch (e) {
      throw _readableDioError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  // ====== Compatibility methods (so your old screens don't break) ======
  Future<void> signUp(String email, String password) async {
    // Your backend requires name too, so we provide a safe default.
    // You can later update register_screen UI to ask name properly.
    await register('User', email, password);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // ====== Helpers ======
  String? _extractToken(dynamic data) {
    if (data is Map) {
      final t = data['token'] ?? data['accessToken'] ?? data['jwt'];
      if (t is String && t.isNotEmpty) return t;
    }
    return null;
  }

  String _readableDioError(DioException e) {
    final data = e.response?.data;

    if (data is Map) {
      final msg = data['message'] ?? data['error'] ?? data['msg'];
      if (msg != null) return msg.toString();
    }

    if (e.type == DioExceptionType.connectionTimeout)
      return 'Connection timeout';
    if (e.type == DioExceptionType.receiveTimeout) return 'Receive timeout';
    if (e.type == DioExceptionType.connectionError)
      return 'No internet / Server not reachable';

    return e.message ?? 'Request failed';
  }
}
