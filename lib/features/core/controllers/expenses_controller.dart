import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/repositories/core_repository/expenses_repository.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  @override
  void onInit() {
    getExpenses();
    super.onInit();
  }

  @override
  void onReady() {
    getExpenses();
    super.onReady();
  }

  var expenses = RxList<ExpenseModel>();

  getExpenses() async {
    var response = await ExpensesRepository().getExpenses();
    expenses.value = response;
  }
}
