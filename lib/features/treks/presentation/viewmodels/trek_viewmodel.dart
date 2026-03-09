import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/trek_remote_datasource.dart';
import '../../data/models/trek_model.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/services/storage/token_storage.dart';

// trek list state
class TrekState {
  final List<TrekModel> treks;
  final bool isLoading;
  final String? error;

  const TrekState({
    this.treks = const [],
    this.isLoading = false,
    this.error,
  });

  TrekState copyWith({
    List<TrekModel>? treks,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return TrekState(
      treks: treks ?? this.treks,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

// trek viewmodel - treks fetch garxa
class TrekViewModel extends StateNotifier<TrekState> {
  TrekViewModel() : super(const TrekState()) {
    // app khulda treks load garxa
    loadTreks();
  }

  Future<void> loadTreks({String? search, String? difficulty}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final token = await TokenStorage().getToken();
      final dio = token != null
          ? ApiClient.createAuthDio(token)
          : ApiClient.createDio();

      final datasource = TrekRemoteDatasource(dio);
      final data = await datasource.getTreks(
        search: search,
        difficulty: difficulty,
      );

      final treks = data.map((e) => TrekModel.fromJson(e)).toList();
      state = state.copyWith(treks: treks, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

// provider
final trekViewModelProvider =
    StateNotifierProvider<TrekViewModel, TrekState>((ref) {
  return TrekViewModel();
});
