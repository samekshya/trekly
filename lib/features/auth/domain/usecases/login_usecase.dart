import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/user_model.dart';
import '../../../../core/services/storage/token_storage.dart';
import '../../../../core/api/api_client.dart';

class LoginUseCase {
  final AuthRemoteDataSource datasource;
  final TokenStorage tokenStorage;

  LoginUseCase({
    required this.datasource,
    required this.tokenStorage,
  });

  Future<UserModel> execute(String email, String password) async {
    // API call garxa login ko lagi
    final response = await datasource.login(email, password);

    // token nikalna
    final token = response['token'] as String;

    // token save garxa device ma
    await tokenStorage.saveToken(token);

    // user data nikalna ra save garxa
    final userJson = response['user'] as Map<String, dynamic>;
    final user = UserModel.fromJson(userJson);
    await tokenStorage.saveUser(user.toJson());

    // user return garxa
    return user;
  }
}
