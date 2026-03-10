import 'package:hive_flutter/hive_flutter.dart';
import '../constants/hive_keys.dart';

class HiveService {
  HiveService._();

  static Future<void> init() async {
    await Hive.initFlutter();

    // Open boxes
    await Hive.openBox(HiveKeys.usersBox);
    await Hive.openBox(HiveKeys.sessionBox);
  }

  static Box getUsersBox() => Hive.box(HiveKeys.usersBox);
  static Box getSessionBox() => Hive.box(HiveKeys.sessionBox);
}
