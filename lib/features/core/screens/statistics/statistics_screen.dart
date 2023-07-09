import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/monthly_barchart_widget.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/monthly_linechart_widget.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/weekly_linechart_widget.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/yearly_linechart_widget.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

final lineCharts = [
  const WeeklyExpensesLineChartWidget(),
  const MonthlyExpensesLineChartWidget(),
  const YearlyExpensesLineChartWidget(),
];

class _StatisticsScreenState extends State<StatisticsScreen> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              // Wrap the Column with Expanded
              child: Column(
                children: [
                  AnimatedButtonBar(
                    radius: 32.0,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    backgroundColor: kTertiaryColor,
                    foregroundColor: kPrimaryColor,
                    elevation: 12,
                    borderColor: kPrimaryColor,
                    borderWidth: 2,
                    innerVerticalPadding: 12,
                    children: [
                      ButtonBarEntry(
                        onTap: () => setState(() => index = 0),
                        child: const Text(
                          "Weekly",
                          style: TextStyle(color: kWhiteColor, fontSize: 16),
                        ),
                      ),
                      ButtonBarEntry(
                        onTap: () => setState(() => index = 1),
                        child: const Text(
                          "Monthly",
                          style: TextStyle(color: kWhiteColor, fontSize: 16),
                        ),
                      ),
                      ButtonBarEntry(
                        onTap: () => setState(() => index = 2),
                        child: const Text(
                          "Yearly",
                          style: TextStyle(color: kWhiteColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  AspectRatio(
                      aspectRatio: 16 / 9, // Choose an appropriate aspect ratio
                      child: lineCharts[index]),
                  const AspectRatio(
                      aspectRatio: 16 / 9, // Choose an appropriate aspect ratio
                      child: MonthlyCategoryBarChartWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
