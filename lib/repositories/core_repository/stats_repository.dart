import 'dart:convert';

import 'package:budget_buddy/features/core/models/forecast_model.dart';
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

  Future<List<ForecastModel>> getForecast(String userId) async {
    try {
      List<ForecastModel> list = [];
      var responseNextWeek =
          await _dio.get('$apiAdress/Budgets/GetNextWeekForecast', //poprawić
              queryParameters: {"userId": userId});
      var jsonDataWeek = responseNextWeek.data as Map<String, dynamic>;

      var forecastWeek = forecastModelFromJson(json.encode(jsonDataWeek));
      list.add(forecastWeek);
      var responseNextMonth = await _dio.get('$apiAdress/Budgets/GetNextMonthForecast',
          queryParameters: {"userId": userId});
      var jsonDataMonth = responseNextMonth.data as Map<String, dynamic>;
      var forecastMonth = forecastModelFromJson(json.encode(jsonDataMonth));
      list.add(forecastMonth);
      var responseNextYear = await _dio.get('$apiAdress/Budgets/GetNextYearForecast',
          queryParameters: {"userId": userId});
      var jsonDataYear = responseNextYear.data as Map<String, dynamic>;
      var forecastYear = forecastModelFromJson(json.encode(jsonDataYear));
      list.add(forecastYear);
      return list;
    } on DioException catch (e) {
      printInfo(info: '${e.response}');
      return [];
    }
  }
}
