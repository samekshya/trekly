import 'package:flutter_test/flutter_test.dart';
import 'package:trekly/features/treks/data/models/trek_model.dart';
import 'package:trekly/features/auth/data/models/user_model.dart';

void main() {
  // ========== USE CASE TESTS (10) ==========
  group('TrekModel UseCases', () {
    test('UC01 - TrekModel.fromJson creates correct model', () {
      final json = {
        '_id': '123',
        'name': 'Poon Hill',
        'location': 'Annapurna, Nepal',
        'difficulty': 'Easy',
        'duration': 3,
        'price': 7000,
        'description': 'A beautiful trek',
        'image': '',
      };
      final trek = TrekModel.fromJson(json);
      expect(trek.id, '123');
      expect(trek.name, 'Poon Hill');
    });

    test('UC02 - TrekModel.fromJson handles missing fields with defaults', () {
      final trek = TrekModel.fromJson({});
      expect(trek.id, '');
      expect(trek.name, '');
      expect(trek.duration, 0);
    });

    test('UC03 - TrekModel difficulty label returns Easy', () {
      final trek = TrekModel.fromJson({'difficulty': 'Easy'});
      expect(trek.difficultyLabel, 'Easy');
    });

    test('UC04 - TrekModel difficulty label returns Moderate', () {
      final trek = TrekModel.fromJson({'difficulty': 'Moderate'});
      expect(trek.difficultyLabel, 'Moderate');
    });

    test('UC05 - TrekModel difficulty label returns Hard', () {
      final trek = TrekModel.fromJson({'difficulty': 'Hard'});
      expect(trek.difficultyLabel, 'Hard');
    });

    test('UC06 - TrekModel price is converted to double', () {
      final trek = TrekModel.fromJson({'price': 5000});
      expect(trek.price, isA<double>());
      expect(trek.price, 5000.0);
    });

    test('UC07 - TrekModel duration is stored correctly', () {
      final trek = TrekModel.fromJson({'duration': 7});
      expect(trek.duration, 7);
    });
  });

  group('UserModel UseCases', () {
    test('UC08 - UserModel.fromJson creates correct model', () {
      final json = {
        '_id': 'u1',
        'name': 'Samek',
        'email': 'samek@gmail.com',
      };
      final user = UserModel.fromJson(json);
      expect(user.id, 'u1');
      expect(user.name, 'Samek');
      expect(user.email, 'samek@gmail.com');
    });

    test('UC09 - UserModel.toJson returns correct map', () {
      final user = UserModel(id: 'u1', name: 'Samek', email: 'samek@gmail.com');
      final json = user.toJson();
      expect(json['name'], 'Samek');
      expect(json['email'], 'samek@gmail.com');
    });

    test('UC10 - UserModel handles missing fields', () {
      final user = UserModel.fromJson({});
      expect(user.id, '');
      expect(user.name, '');
      expect(user.email, '');
    });
  });
}
