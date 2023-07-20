import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpentWidget extends StatelessWidget {
  const SpentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    final size = MediaQuery.of(context).size;
    final budgetValue = budgetController.budget.value;
    final budgetSpent = budgetValue.budgetSpent ?? 0.0;
    final budgetLimit = budgetValue.budgetLimit ?? 0.0;
    final spentPercentage = (budgetSpent * 100 / budgetLimit).round();

    bool isOverBudget = spentPercentage > 100;

    return Container(
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: size.height * 0.18,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'This month spend',
          style: TextStyle(color: kWhiteColor, fontSize: 16),
        ),
        Text(
          isOverBudget
              ? '+ ${(budgetSpent - budgetLimit).toStringAsFixed(2)}'
              : '${budgetSpent.toStringAsFixed(2)} zł',
          style: const TextStyle(color: kWhiteColor, fontSize: 36),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        LinearPercentIndicator(
          lineHeight: 16,
          backgroundColor: kSecondaryColor,
          trailing: Text(
            isOverBudget ? '' : '$spentPercentage%  ',
            style: const TextStyle(color: kWhiteColor),
          ),
          progressColor: isOverBudget ? Colors.red : kPrimaryColor,
          percent: isOverBudget ? 1.0 : spentPercentage.toDouble() / 100.0,
          barRadius: const Radius.circular(100),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          isOverBudget ? 'Over Budget' : 'of total balance',
          style: const TextStyle(color: kWhiteColor, fontSize: 16),
        )
      ]),
    );
  }
}
