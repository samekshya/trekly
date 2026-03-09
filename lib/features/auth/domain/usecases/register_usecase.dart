import '../../data/datasources/auth_remote_datasource.dart';

class RegisterUseCase {
  final AuthRemoteDataSource datasource;

  RegisterUseCase({required this.datasource});

  Future<void> execute(String name, String email, String password) async {
    // register API call garxa
    await datasource.register(
      name: name,
      email: email,
      password: password,
    );
  }
}
