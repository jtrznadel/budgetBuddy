import 'dart:convert';

import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
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
        var jsonData = response.data as Map<String, dynamic>?;

        if (jsonData != null) {
          var expensesData = jsonData['expenses'] as List<dynamic>;
          var expenses = expenseModelFromJson(json.encode(expensesData));
          return expenses;
        } else {
          // Return an empty list if the response data is null
          return [];
        }
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

  Future<int> removeExpense(ExpenseModel expense) async {
    try {
      var response = await _dio.delete('$apiAdress/Expenses/${expense.expenseId}');
      return response.statusCode!;
    } on DioException catch (e) {
      printInfo(info: '${e.response}');
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    try {
      String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(expense.date!);
      var response = await _dio.put('$apiAdress/Expenses/${expense.expenseId}', data: {
        "expenseId": expense.expenseId,
        "name": expense.name,
        "description": expense.description,
        "price": expense.price,
        "date": formattedDate, // Format the date before sending it to the API
        "categoryId": expense.categoryId,
        "userId": expense.userId
      });

      return response.statusCode!;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }
}
