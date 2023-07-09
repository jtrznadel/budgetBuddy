import 'package:budget_buddy/constants/color_palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyCategoryBarChartWidget extends StatelessWidget {
  const MonthlyCategoryBarChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(minY: 0, maxY: 200, barGroups: [
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(fromY: 0, toY: 100, width: 15, color: kPrimaryColor),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(fromY: 0, toY: 120, width: 15, color: kPrimaryColor),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(fromY: 0, toY: 130, width: 15, color: kPrimaryColor),
      ]),
    ]));
  }
}
