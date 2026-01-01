import 'package:hive/hive.dart';
import '../../../../core/constants/hive_keys.dart';

class AuthHiveDataSource {
  final Box usersBox;
  final Box sessionBox;

  AuthHiveDataSource({required this.usersBox, required this.sessionBox});

  bool userExists(String email) {
    return usersBox.containsKey(email);
  }

  void saveUser({required String email, required String password}) {
    usersBox.put(email, {'email': email, 'password': password});
  }

  Map<String, dynamic>? getUser(String email) {
    final data = usersBox.get(email);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  void saveSession(String email) {
    sessionBox.put(HiveKeys.isLoggedIn, true);
    sessionBox.put(HiveKeys.currentUserEmail, email);
  }

  bool isLoggedIn() {
    return sessionBox.get(HiveKeys.isLoggedIn, defaultValue: false);
  }

  void clearSession() {
    sessionBox.clear();
  }
}
