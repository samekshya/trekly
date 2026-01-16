import 'package:hive/hive.dart';

class TokenStorage {
  static const _box = "authBox";
  static const _key = "token";

  Future<void> save(String token) async {
    final box = await Hive.openBox(_box);
    await box.put(_key, token);
  }

  Future<String?> read() async {
    final box = await Hive.openBox(_box);
    return box.get(_key) as String?;
  }

  Future<void> clear() async {
    final box = await Hive.openBox(_box);
    await box.delete(_key);
  }
}
