import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/services/storage/token_storage.dart';

// auth state - state of the app
class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  // logged in chha ki chhhaina check garxa
  bool get isLoggedIn => user != null;

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

// auth viewmodel - sabai logic yaha hunxa
class AuthViewModel extends StateNotifier<AuthState> {
  final TokenStorage _tokenStorage;

  AuthViewModel(this._tokenStorage) : super(const AuthState()) {
    // app khulda auto login check garxa
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    // token chha bhane user lai home pathauxa
    final hasToken = await _tokenStorage.hasToken();
    if (!hasToken) return;

    final userData = await _tokenStorage.getUser();
    if (userData != null) {
      state = state.copyWith(user: UserModel.fromJson(userData));
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final dio = ApiClient.createDio();
      final datasource = AuthRemoteDataSource(dio);
      final usecase = LoginUseCase(
        datasource: datasource,
        tokenStorage: _tokenStorage,
      );

      final user = await usecase.execute(email, password);
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      // error aayo bhane error state ma rakhxa
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception:', '').trim(),
      );
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final dio = ApiClient.createDio();
      final datasource = AuthRemoteDataSource(dio);
      final usecase = RegisterUseCase(datasource: datasource);

      await usecase.execute(name, email, password);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception:', '').trim(),
      );
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final dio = ApiClient.createDio();
      final datasource = AuthRemoteDataSource(dio);
      final usecase = ForgotPasswordUseCase(datasource: datasource);

      await usecase.execute(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception:', '').trim(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    // sab data delete garxa
    await _tokenStorage.clear();
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

// provider - riverpod le inject garxa
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(TokenStorage());
});
