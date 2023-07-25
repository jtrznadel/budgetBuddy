import 'package:budget_buddy/auth/secrets.dart';
import 'package:budget_buddy/features/core/models/budget_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BudgetRepository {
  final Dio _dio = Dio();

  Future<BudgetModel> getUserBudget(String userId) async {
    try {
      var response =
          await _dio.get('$apiAdress/Budgets/GetBudgetForUser', queryParameters: {
        "userId": userId,
      });
      if (response.statusCode == 200) {
        var jsonData = response.data as Map<String, dynamic>;

        if (jsonData.isNotEmpty) {
          // Assuming the data in the response is the budget object
          var budget = BudgetModel.fromJson(jsonData);
          return budget;
        } else {
          // Handle the case when the data is empty (budget not found)
          throw Exception("Budget not found");
        }
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      throw e.response!.data;
    }
  }

  Future<int> updateBudget(BudgetModel budget) async {
    try {
      var response =
          await _dio.put('$apiAdress/Budgets/${budget.budgetId}', queryParameters: {
        "userId": '${budget.userId}'
      }, data: {
        "budgetLimit": budget.budgetLimit,
      });
      return response.data.statusCode;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      printInfo(info: '${e.response}');
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }
}
