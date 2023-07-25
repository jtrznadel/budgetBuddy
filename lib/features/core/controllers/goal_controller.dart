import 'package:budget_buddy/features/core/models/goal_model.dart';
import 'package:budget_buddy/repositories/core_repository/goals_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class GoalController extends GetxController {
  @override
  void onInit() {
    getGoals();
  }

  var goals = RxList<GoalModel>();
  final storage = const FlutterSecureStorage();

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getGoals() async {
    var userId = await getUserId();
    var response = await GoalsRepository().getGoals(userId);
    DateTime today = DateTime.now();
    List<GoalModel> filteredGoals = response
        .where((goal) =>
            goal.deadline != null &&
            goal.deadline!.isAfter(today) &&
            goal.actualAmount! <= goal.goalAmount!)
        .toList();

    goals.value = filteredGoals;
  }

  addGoal(GoalModel goal) async {
    var userId = await getUserId();
    goal.userId = int.parse(userId);
    var response = await GoalsRepository().addGoal(goal);
    refreshGoals();
  }

  addAmountToGoal(GoalModel goal) async {
    var userId = await getUserId();
    goal.userId = int.parse(userId);
    var response = await GoalsRepository().updateGoal(goal);
    refreshGoals();
  }

  removeGoal(GoalModel goal) async {
    var response = await GoalsRepository().removeGoal(goal);
    refreshGoals();
  }

  updateGoal(GoalModel goal) async {
    var userId = await getUserId();
    goal.userId = int.parse(userId);
    var response = await GoalsRepository().updateGoal(goal);
    refreshGoals();
  }

  refreshGoals() {
    getGoals();
    update();
  }
}
