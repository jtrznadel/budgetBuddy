import 'package:budget_buddy/features/core/models/expense_model.dart';

class AdvancedExpenseModel {
  List<ExpenseModel> expenses;
  int totalExpenses;

  AdvancedExpenseModel({
    required this.expenses,
    required this.totalExpenses,
  });
}
