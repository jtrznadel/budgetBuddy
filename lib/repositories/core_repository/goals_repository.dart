import 'package:budget_buddy/auth/secrets.dart';
import 'package:budget_buddy/features/core/models/goal_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GoalsRepository {
  final Dio _dio = Dio();

  Future<List<GoalModel>> getGoals(String userId) async {
    try {
      var response = await _dio.get('$apiAdress/Goals/user/$userId', queryParameters: {
        "userId": userId,
      });
      if (response.statusCode == 200) {
        var jsonData = response.data as List<dynamic>;

        if (jsonData.isNotEmpty) {
          List<GoalModel> goals =
              jsonData.map((item) => GoalModel.fromJson(item)).toList();
          return goals;
        } else {
          // Return an empty list if the response data is empty
          return [];
        }
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      throw e.response!.data;
    }
  }

  Future<int> updateGoal(GoalModel goal) async {
    try {
      String formattedDeadline = goal.deadline!.toIso8601String();

      var response = await _dio.put('$apiAdress/Goals/${goal.id}', data: {
        "id": goal.id,
        "userId": goal.userId,
        "name": goal.name,
        "icon": goal.icon,
        "deadline": formattedDeadline,
        "goalAmount": goal.goalAmount,
        "actualAmount": goal.actualAmount
      });

      return response.statusCode!;
    } on DioException catch (e) {
      printError(info: '$e');
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }

  Future<GoalModel> addGoal(GoalModel goal) async {
    try {
      String formattedDeadline = goal.deadline!.toIso8601String();
      var response = await _dio.post(
        '$apiAdress/Goals',
        data: {
          "userId": goal.userId,
          "name": goal.name,
          "icon": goal.icon,
          "deadline": formattedDeadline,
          "goalAmount": goal.goalAmount,
          "actualAmount": goal.actualAmount
        },
      );
      if (response.statusCode == 201) {
        var jsonData = response.data;
        var addedGoal = GoalModel.fromJson(jsonData);
        return addedGoal;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      printError(info: '$e');
      throw e.response!.data;
    }
  }
}
