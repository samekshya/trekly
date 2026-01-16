import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as r;
import 'package:flutter_riverpod/legacy.dart' as rl;

import '../../../../core/api/api_client.dart';
import '../../../../core/services/storage/token_storage.dart';
import '../../data/datasources/auth_remote_datasource.dart';

final dioProvider = r.Provider<Dio>((ref) {
  return ApiClient.createDio();
});

final authRemoteDataSourceProvider = r.Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDataSource(dio);
});

final tokenStorageProvider = r.Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final authViewModelProvider =
    rl.StateNotifierProvider<AuthViewModel, r.AsyncValue<void>>((ref) {
      return AuthViewModel(ref);
    });

class AuthViewModel extends rl.StateNotifier<r.AsyncValue<void>> {
  AuthViewModel(this.ref) : super(const r.AsyncData(null));
  final r.Ref ref;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const r.AsyncLoading();
    try {
      await ref
          .read(authRemoteDataSourceProvider)
          .register(name: name, email: email, password: password);
      state = const r.AsyncData(null);
    } catch (e, st) {
      state = r.AsyncError(e, st);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const r.AsyncLoading();
    try {
      final res = await ref
          .read(authRemoteDataSourceProvider)
          .login(email, password);

      final token = _extractToken(res);
      if (token == null || token.isEmpty) {
        throw Exception("Token missing in response");
      }

      await ref.read(tokenStorageProvider).save(token);
      state = const r.AsyncData(null);
    } catch (e, st) {
      state = r.AsyncError(e, st);
    }
  }

  // String? _extractToken(Map<String, dynamic> res) {
  //   final t = res["token"] ?? res["accessToken"] ?? res["jwt"];
  //   return t?.toString();
  // }
}
