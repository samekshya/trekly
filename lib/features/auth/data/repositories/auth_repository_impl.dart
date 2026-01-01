import '../datasources/auth_hive_datasource.dart';

class AuthRepository {
  final AuthHiveDataSource dataSource;

  AuthRepository(this.dataSource);

  void signUp(String email, String password) {
    if (dataSource.userExists(email)) {
      throw Exception('User already exists');
    }
    dataSource.saveUser(email: email, password: password);
  }

  void login(String email, String password) {
    final user = dataSource.getUser(email);
    if (user == null) {
      throw Exception('User not found');
    }
    if (user['password'] != password) {
      throw Exception('Invalid password');
    }
    dataSource.saveSession(email);
  }

  bool isLoggedIn() {
    return dataSource.isLoggedIn();
  }

  void logout() {
    dataSource.clearSession();
  }
}
