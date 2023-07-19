import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseWidget extends StatelessWidget {
  final ExpenseModel expense;
  final int icon;
  const ExpenseWidget({super.key, required this.expense, required this.icon});

  @override
  Widget build(BuildContext context) {
    final String displayExpenseName = expense.name!.length <= 20
        ? expense.name!
        : "${expense.name!.substring(0, 20)}...";
    return Container(
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
    );
  }
}
