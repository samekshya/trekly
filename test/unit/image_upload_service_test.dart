import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:trekly/features/upload/data/image_upload_service.dart';

class MockDio extends Mock implements Dio {}

Future<File> createTempTestFile() async {
  final dir = Directory.systemTemp.createTempSync('trekly_test_');
  final file = File('${dir.path}/fake_image.jpg');
  await file.writeAsBytes([0, 1, 2, 3, 4]); // dummy bytes
  return file;
}

void main() {
  late MockDio mockDio;
  late ImageUploadService service;

  setUp(() {
    mockDio = MockDio();
    service = ImageUploadService(dio: mockDio);
  });

  test('returns imageUrl when upload is successful', () async {
    final file = await createTempTestFile();

    when(
      () => mockDio.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {'success': true, 'imageUrl': 'http://server.com/image.jpg'},
      ),
    );

    final result = await service.uploadImage(file);

    expect(result, 'http://server.com/image.jpg');
  });

  test('throws exception when server returns success false', () async {
    final file = await createTempTestFile();

    when(
      () => mockDio.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {'success': false},
      ),
    );

    expect(() => service.uploadImage(file), throwsException);
  });

  test('throws exception when response is not a Map', () async {
    final file = await createTempTestFile();

    when(
      () => mockDio.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: 'invalid response',
      ),
    );

    expect(() => service.uploadImage(file), throwsException);
  });

  test('throws exception when dio throws error', () async {
    final file = await createTempTestFile();

    when(
      () => mockDio.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

    expect(() => service.uploadImage(file), throwsException);
  });

  test('calls correct upload endpoint', () async {
    final file = await createTempTestFile();

    when(
      () => mockDio.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {'success': true, 'imageUrl': 'http://server.com/image.jpg'},
      ),
    );

    await service.uploadImage(file);

    verify(
      () => mockDio.post(
        'http://10.0.2.2:5050/api/upload',
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).called(1);
  });
}
