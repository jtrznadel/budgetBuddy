import 'package:budget_buddy/auth/secrets.dart';
import 'package:budget_buddy/features/core/models/budget_model.dart';
import 'package:dio/dio.dart';

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
      throw e.response!.data;
    }
  }
}
