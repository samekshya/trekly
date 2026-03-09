import 'package:dio/dio.dart';
import '../../../../core/api/api_endpoints.dart';

class TrekRemoteDatasource {
  final Dio _dio;

  TrekRemoteDatasource(this._dio);

  // sabai treks lyauxa API bata
  Future<List<Map<String, dynamic>>> getTreks({
    String? search,
    String? difficulty,
  }) async {
    final queryParams = <String, dynamic>{};
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    if (difficulty != null && difficulty.isNotEmpty) {
      queryParams['difficulty'] = difficulty;
    }

    final res = await _dio.get(
      ApiEndpoints.treks,
      queryParameters: queryParams,
    );

    // API le data array return garxa
    final data = res.data['data'] as List;
    return data.cast<Map<String, dynamic>>();
  }

  // eutai trek lyauxa id le
  Future<Map<String, dynamic>> getTrekById(String id) async {
    final res = await _dio.get(ApiEndpoints.trekById(id));
    return res.data['data'] as Map<String, dynamic>;
  }
}
