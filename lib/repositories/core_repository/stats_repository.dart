import 'dart:convert';

import 'package:budget_buddy/features/core/models/stats_info_model.dart';
import 'package:budget_buddy/features/core/models/stats_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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

  Future<StatsInfoModel> getStatsInfo(String userId, int period) async {
    try {
      var response = await _dio.get('$apiAdress/Budgets/GetExpenseStatisticsForPeriod',
          queryParameters: {"userId": userId, "period": period});
      if (response.statusCode == 200) {
        var jsonData = response.data as Map<String, dynamic>;

        var stats = statsInfoModelFromJson(json.encode(jsonData));
        return stats;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }

  Future<List<dynamic>> getForecast(String userId) async {
    try {
      var list = [];
      var responseNextWeek = await _dio.get('$apiAdress/Budgets/GetGetNextWeekForecast',
          queryParameters: {"userId": userId});
      list.add(responseNextWeek.data);
      var responseNextMonth = await _dio.get('$apiAdress/Budgets/GetNextMonthForecast',
          queryParameters: {"userId": userId});
      list.add(responseNextMonth.data);
      var responseNextYear = await _dio.get('$apiAdress/Budgets/GetNextYearForecast',
          queryParameters: {"userId": userId});
      list.add(responseNextYear.data);
      return list;
    } on DioException catch (e) {
      printInfo(info: '${e.response}');
      return [];
    }
  }
}
