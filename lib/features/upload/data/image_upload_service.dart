import 'dart:io';
import 'package:dio/dio.dart';

class ImageUploadService {
  ImageUploadService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  // Android emulator → 10.0.2.2
  static const String baseUrl = 'http://10.0.2.2:5050';

  Future<String> uploadImage(File imageFile) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split(Platform.pathSeparator).last,
      ),
    });

    final response = await _dio.post(
      '$baseUrl/api/upload',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data;

    if (data is Map && data['success'] == true) {
      return data['imageUrl'] as String;
    }

    throw Exception('Image upload failed');
  }
}
