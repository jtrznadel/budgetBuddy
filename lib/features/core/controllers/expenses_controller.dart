import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/repositories/core_repository/expenses_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpensesController extends GetxController {
  @override
  void onInit() {
    getExpenses();
    getSelectedExpenses();
    super.onInit();
  }

  @override
  void onReady() {
    getExpenses();
    getSelectedExpenses();
    super.onReady();
  }

  var expenses = RxList<ExpenseModel>();
  var selectedExpenses = RxList<ExpenseModel>();
  var selectedCategory = RxInt(0);
  var selectedDate = RxString('');
  final storage = const FlutterSecureStorage();

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getExpenses() async {
    var userId = await getUserId();
    var response = await ExpensesRepository().getExpenses(userId);
    expenses.value = response;
  }

  getSelectedExpenses() async {
    var userId = await getUserId();

    var response = await ExpensesRepository().getExpenses(userId);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if (selectedCategory.value != 0 && selectedDate.value.isNotEmpty) {
      selectedExpenses.value = response
          .where((expense) =>
              expense.categoryId == selectedCategory.value &&
              formatter.format(expense.date!).toString() == selectedDate.value)
          .toList();
    } else if (selectedCategory.value != 0) {
      selectedExpenses.value = response
          .where((expense) => expense.categoryId == selectedCategory.value)
          .toList();
    } else if (selectedDate.value.isNotEmpty) {
      selectedExpenses.value = response
          .where((expense) =>
              formatter.format(expense.date!).toString() == selectedDate.value)
          .toList();
      print(selectedDate.value);
    } else {
      selectedExpenses.value = response;
    }
  }

  setSelectedCategory(int id) {
    if (selectedCategory.value == id) {
      selectedCategory.value =
          0; // Jeśli kliknięto ten sam przycisk drugi raz, zmień stan na niezaznaczony (0).
    } else {
      selectedCategory.value = id;
    }
    update();
  }

  addExpense(ExpenseModel expense) async {
    var userId = await getUserId();
    expense.userId = int.parse(userId);
    try {
      var addedExpense = await ExpensesRepository().addExpense(expense);
      // Dodaj nową kategorię do listy użytkownika
      //userCategories.add(addedCategory);
    } catch (error) {
      // Obsłuż błąd
      printError(info: 'Error adding exponse: $error');
    }
  }
}
