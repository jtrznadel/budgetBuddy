import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/features/core/screens/expenses/widgets/edit_expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdvancedExpenseWidget extends StatelessWidget {
  final ExpenseModel expense;
  final int icon;
  const AdvancedExpenseWidget({super.key, required this.expense, required this.icon});

  @override
  Widget build(BuildContext context) {
    final expensesController = Get.find<ExpensesController>();

    final String displayExpenseName = expense.name!.length <= 20
        ? expense.name!
        : "${expense.name!.substring(0, 20)}...";
    return Slidable(
      key: Key(expense.name!),
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
            onPressed: (context) {
              expensesController.removeExpense(expense);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(0),
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25), bottomRight: Radius.circular(25))),
      ]),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return EditExpenseModal(expense: expense);
                  },
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              padding: const EdgeInsets.all(0),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(right: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kWhiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kSecondaryColor,
                  ),
                  width: 60,
                  height: 60,
                  child: Icon(
                    IconData(icon, fontFamily: 'MaterialIcons'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayExpenseName,
                    ),
                    Text(DateFormat.yMMMd().format(expense.date!))
                  ],
                ),
              ],
            ),
            Text(
              "-${expense.price} zł",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
