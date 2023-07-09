import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/repositories/core_repository/expenses_repository.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  @override
  void onInit() {
    getExpenses();
    getSelectedExpenses(null);
    super.onInit();
  }

  @override
  void onReady() {
    getExpenses();
    super.onReady();
    getSelectedExpenses(null);
  }

  var expenses = RxList<ExpenseModel>();
  var selectedExpenses = RxList<ExpenseModel>();

  getExpenses() async {
    var response = await ExpensesRepository().getExpenses();
    expenses.value = response;
  }

  getSelectedExpenses(int? id) async {
    var response = await ExpensesRepository().getExpenses();
    if (id != null) {
      selectedExpenses.value =
          response.where((expense) => expense.categoryId == id).toList();
    } else {
      selectedExpenses.value = response;
    }
  }
}
