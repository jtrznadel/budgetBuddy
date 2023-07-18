import 'dart:convert';

import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../auth/secrets.dart';

class ExpensesRepository {
  final Dio _dio = Dio();

  Future<List<ExpenseModel>> getExpenses(String userId) async {
    try {
      var response =
          await _dio.get('$apiAdress/Budgets/GetTotalExpensesForUser', queryParameters: {
        "userId": userId,
      });
      if (response.statusCode == 200) {
        var jsonData = response.data as Map<String, dynamic>;
        var expensesData = jsonData['expenses'] as List<dynamic>;
        var expenses = expenseModelFromJson(json.encode(expensesData));
        return expenses;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }

  Future<ExpenseModel> addExpense(ExpenseModel expense) async {
    try {
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(now);
      var response = await _dio.post(
        '$apiAdress/Expenses',
        data: {
          'name': '${expense.name}',
          'description': 'string',
          'price': '${expense.price}',
          'date': formattedDateTime,
          'categoryId': '${expense.categoryId}',
          'userId': '${expense.userId}'
        },
      );
      if (response.statusCode == 201) {
        var jsonData = response.data;
        var addedExpense = ExpenseModel.fromJson(jsonData);
        return addedExpense;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }
}
