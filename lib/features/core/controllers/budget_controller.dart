import 'package:budget_buddy/features/core/models/budget_model.dart';
import 'package:budget_buddy/repositories/core_repository/budget_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  @override
  void onInit() {
    getBudget();
    super.onInit();
  }

  final storage = const FlutterSecureStorage();
  var budget = Rx<BudgetModel>(BudgetModel());

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getBudget() async {
    var userId = await getUserId();
    var response = await BudgetRepository().getUserBudget(userId);
    budget.value = response;
  }

  refreshBudget() {
    getBudget();
    update(); // Wywołanie update() spowoduje, że GetBuilder, Obx itp. zostaną ponownie zbudowane z aktualnymi danymi
  }

  updateBudget(double limit) async {
    budget.value.budgetLimit = limit.toInt();
    var response = await BudgetRepository().updateBudget(budget.value);
    getBudget();
  }
}
