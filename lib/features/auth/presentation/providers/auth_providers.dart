import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/hive_keys.dart';
import '../../data/datasources/auth_hive_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';

final usersBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveKeys.usersBox);
});

final sessionBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveKeys.sessionBox);
});

final authDataSourceProvider = Provider<AuthHiveDataSource>((ref) {
  return AuthHiveDataSource(
    usersBox: ref.read(usersBoxProvider),
    sessionBox: ref.read(sessionBoxProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(authDataSourceProvider));
});
