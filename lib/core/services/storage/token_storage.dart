import 'package:hive/hive.dart';

class TokenStorage {
  static const _boxName = 'authBox';
  static const _tokenKey = 'token';
  static const _userKey = 'user';

  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_tokenKey) as String?;
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_userKey, user);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final box = await Hive.openBox(_boxName);
    final data = box.get(_userKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clear() async {
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
