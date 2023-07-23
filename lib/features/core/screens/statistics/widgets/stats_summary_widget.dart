import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:flutter/material.dart';

class StatsSummary extends StatelessWidget {
  final double totalExpensesForPeriod;
  final String mostSpentCategory;
  final String mostFrequentCategory;
  final String leastSpentCategory;
  final String categoriesWithNoExpenses;

  const StatsSummary({
    super.key,
    required this.totalExpensesForPeriod,
    required this.mostSpentCategory,
    required this.mostFrequentCategory,
    required this.leastSpentCategory,
    required this.categoriesWithNoExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              text: const TextSpan(
                  text: "More",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                    text: " .stats",
                    style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Expenses for Period: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                totalExpensesForPeriod.toStringAsFixed(2),
                style: const TextStyle(
                    color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most Spent Category: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                mostSpentCategory,
                style: const TextStyle(
                    color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most Frequent Category: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                mostFrequentCategory,
                style: const TextStyle(
                    color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Least Spent Category: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                leastSpentCategory,
                style: const TextStyle(
                    color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories with No Expenses: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                categoriesWithNoExpenses,
                style: const TextStyle(
                    color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
