import 'package:flutter_test/flutter_test.dart';
import 'package:trekly/features/treks/data/models/trek_model.dart';
import 'package:trekly/features/treks/presentation/viewmodels/trek_viewmodel.dart';
import 'package:trekly/features/auth/presentation/viewmodels/auth_viewmodel.dart';

void main() {
  // ========== VIEWMODEL TESTS (10) ==========
  group('TrekState ViewModel', () {
    test('VM01 - TrekState default values are correct', () {
      const state = TrekState();
      expect(state.treks, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, null);
    });

    test('VM02 - TrekState copyWith updates isLoading', () {
      const state = TrekState();
      final updated = state.copyWith(isLoading: true);
      expect(updated.isLoading, true);
    });

    test('VM03 - TrekState copyWith updates treks list', () {
      const state = TrekState();
      final trek = TrekModel.fromJson({
        '_id': '1',
        'name': 'Test Trek',
        'location': 'Nepal',
        'difficulty': 'Easy',
        'duration': 2,
        'price': 1000,
        'description': 'Test',
        'image': '',
      });
      final updated = state.copyWith(treks: [trek]);
      expect(updated.treks.length, 1);
      expect(updated.treks.first.name, 'Test Trek');
    });

    test('VM04 - TrekState copyWith updates error', () {
      const state = TrekState();
      final updated = state.copyWith(error: 'Network error');
      expect(updated.error, 'Network error');
    });

    test('VM05 - TrekState copyWith clearError removes error', () {
      const state = TrekState(error: 'Some error');
      final updated = state.copyWith(clearError: true);
      expect(updated.error, null);
    });

    test('VM06 - TrekState copyWith keeps existing treks if not updated', () {
      final trek = TrekModel.fromJson({'_id': '1', 'name': 'Trek'});
      final state = TrekState(treks: [trek]);
      final updated = state.copyWith(isLoading: true);
      expect(updated.treks.length, 1);
    });

    test('VM07 - TrekState with multiple treks', () {
      final treks = [
        TrekModel.fromJson({'_id': '1', 'name': 'Trek 1'}),
        TrekModel.fromJson({'_id': '2', 'name': 'Trek 2'}),
        TrekModel.fromJson({'_id': '3', 'name': 'Trek 3'}),
      ];
      final state = TrekState(treks: treks);
      expect(state.treks.length, 3);
    });
  });

  group('AuthState ViewModel', () {
    test('VM08 - AuthState default values are correct', () {
      const state = AuthState();
      expect(state.isLoading, false);
      expect(state.isLoggedIn, false);
      expect(state.user, null);
      expect(state.error, null);
    });

    test('VM09 - AuthState copyWith updates isLoading', () {
      const state = AuthState();
      final updated = state.copyWith(isLoading: true);
      expect(updated.isLoading, true);
      expect(updated.isLoggedIn, false);
    });

    test('VM10 - AuthState copyWith updates error message', () {
      const state = AuthState();
      final updated = state.copyWith(error: 'Invalid credentials');
      expect(updated.error, 'Invalid credentials');
    });
  });
}
