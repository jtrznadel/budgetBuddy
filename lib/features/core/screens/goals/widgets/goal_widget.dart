import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/controllers/goal_controller.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/features/core/models/goal_model.dart';
import 'package:budget_buddy/features/core/screens/goals/widgets/edit_goal_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalWidget extends StatelessWidget {
  final GoalModel goal;
  const GoalWidget({
    required this.goal,
    Key? key,
  }) : super(key: key);

  void _showInputDialog(BuildContext context) {
    final goalController = Get.find<GoalController>();
    final expensesController = Get.find<ExpensesController>();
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Amount'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter amount'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String amount = controller.text;
                if (amount.isNotEmpty) {
                  goal.actualAmount = goal.actualAmount! + double.parse(amount);
                  goalController.addAmountToGoal(goal);
                  var expense = ExpenseModel(
                    name: 'Deposit on goal - ${goal.name}',
                    description: '',
                    price: double.parse(amount),
                    date: DateTime.now(),
                    userId: goal.userId,
                    categoryId: 13,
                  );
                  expensesController.addExpense(expense);
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final goalController = Get.find<GoalController>();
    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    DateTime futureDate = goal.deadline!;

    Duration difference = futureDate.difference(now);
    double goalAmount = goal.goalAmount!;
    double actualAmount = goal.actualAmount!;
    double percent = actualAmount / goalAmount;

    return Slidable(
      key: Key(goal.name!),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return EditGoalModal(goal: goal);
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
        SlidableAction(
            onPressed: (context) {
              goalController.removeGoal(goal);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(0),
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25), bottomRight: Radius.circular(25))),
      ]),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kTertiaryColor,
                      ),
                      width: 60,
                      height: 60,
                      child: Icon(
                        IconData(int.parse(goal.icon!), fontFamily: 'MaterialIcons'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${goal.name}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text('${difference.inDays} days left'),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _showInputDialog(context); // Show the input dialog on tap
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTertiaryColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  percent < 0.35
                      ? 'Come On!'
                      : percent < 0.7
                          ? 'Almost There!'
                          : 'You have almost done this!',
                ),
                Text('$goalAmount'),
              ],
            ),
            const SizedBox(height: 5),
            LinearPercentIndicator(
              lineHeight: 16,
              backgroundColor: kSecondaryColor,
              trailing: const Text(
                '',
                style: TextStyle(color: kWhiteColor),
              ),
              progressColor: percent < 0.35
                  ? Colors.red
                  : percent < 0.7
                      ? Colors.yellow
                      : Colors.green,
              percent: percent,
              barRadius: const Radius.circular(100),
            ),
          ],
        ),
      ),
    );
  }
}
