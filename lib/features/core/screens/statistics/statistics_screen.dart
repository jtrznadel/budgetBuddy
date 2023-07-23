import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/stats_controller.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/monthly_linechart_widget.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/weekly_linechart_widget.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/charts/yearly_linechart_widget.dart';
import 'package:budget_buddy/features/core/screens/statistics/widgets/stats_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int index = 0;
  final statsController = Get.find<StatsController>();

  @override
  Widget build(BuildContext context) {
    statsController.getStatsInfo();
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
                    padding: const EdgeInsets.only(bottom: kDefaultPadding),
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
                          "Last 7 days",
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
                    aspectRatio: 1.5, // Choose an appropriate aspect ratio
                    child: (index == 0)
                        ? WeeklyExpensesLineChartWidget(
                            dailyData: statsController.stats.value.daily)
                        : (index == 1)
                            ? MonthlyExpensesLineChartWidget(
                                monthlyData:
                                    statsController.stats.value.dailyCurrentMonth)
                            : YearlyExpensesLineChartWidget(
                                monthlyData: statsController.stats.value.monthly,
                              ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  index == 0
                      ? StatsSummary(
                          totalExpensesForPeriod:
                              statsController.statsInfoWeek.value.totalExpensesForPeriod!,
                          mostSpentCategory: statsController
                              .statsInfoWeek.value.mostSpentCategory!.category!.name!,
                          mostFrequentCategory: statsController
                              .statsInfoWeek.value.mostFrequentCategory!.category!.name!,
                          leastSpentCategory: statsController
                              .statsInfoWeek.value.leastSpentCategory!.category!.name!,
                          categoriesWithNoExpenses: statsController.statsInfoWeek.value
                              .categoriesWithNoExpenses![0].category!.name!,
                        )
                      : index == 1
                          ? StatsSummary(
                              totalExpensesForPeriod: statsController
                                  .statsInfoMonth.value.totalExpensesForPeriod!,
                              mostSpentCategory: statsController.statsInfoMonth.value
                                  .mostSpentCategory!.category!.name!,
                              mostFrequentCategory: statsController.statsInfoMonth.value
                                  .mostFrequentCategory!.category!.name!,
                              leastSpentCategory: statsController.statsInfoMonth.value
                                  .leastSpentCategory!.category!.name!,
                              categoriesWithNoExpenses: statsController.statsInfoMonth
                                  .value.categoriesWithNoExpenses![0].category!.name!,
                            )
                          : StatsSummary(
                              totalExpensesForPeriod: statsController
                                  .statsInfoYear.value.totalExpensesForPeriod!,
                              mostSpentCategory: statsController
                                  .statsInfoYear.value.mostSpentCategory!.category!.name!,
                              mostFrequentCategory: statsController.statsInfoYear.value
                                  .mostFrequentCategory!.category!.name!,
                              leastSpentCategory: statsController.statsInfoYear.value
                                  .leastSpentCategory!.category!.name!,
                              categoriesWithNoExpenses: statsController.statsInfoYear
                                  .value.categoriesWithNoExpenses![0].category!.name!,
                            )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
