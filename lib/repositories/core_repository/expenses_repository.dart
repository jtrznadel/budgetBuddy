import 'dart:convert';

import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:dio/dio.dart';

import '../../auth/secrets.dart';

class ExpensesRepository {
  final Dio _dio = Dio();

  Future<List<ExpenseModel>> getExpenses() async {
    try {
      var response = await _dio.get('$apiAdress/Expenses');
      if (response.statusCode == 200) {
        var jsonData = response.data as List<dynamic>;
        var expenses = expenseModelFromJson(json.encode(jsonData));
        return expenses;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }
}
