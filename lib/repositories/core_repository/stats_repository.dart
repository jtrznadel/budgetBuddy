import 'dart:convert';

import 'package:budget_buddy/features/core/models/stats_model.dart';
import 'package:dio/dio.dart';

import '../../auth/secrets.dart';

class StatsRepository {
  final Dio _dio = Dio();

  Future<StatsModel> getStats(String userId) async {
    try {
      var response =
          await _dio.get('$apiAdress/Budgets/GetExpenseSummaries', queryParameters: {
        "userId": userId,
      });
      if (response.statusCode == 200) {
        var jsonData = response.data as Map<String, dynamic>;

        var stats = statsModelFromJson(json.encode(jsonData));
        return stats;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }
}
