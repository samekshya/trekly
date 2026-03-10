import '../../data/datasources/auth_remote_datasource.dart';

class ForgotPasswordUseCase {
  final AuthRemoteDataSource datasource;

  ForgotPasswordUseCase({required this.datasource});

  Future<void> execute(String email) async {
    // reset email pathauxa
    await datasource.forgotPassword(email);
  }
}
