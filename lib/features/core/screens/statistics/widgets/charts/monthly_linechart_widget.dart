import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/color_palette.dart';

class MonthlyExpensesLineChartWidget extends StatelessWidget {
  const MonthlyExpensesLineChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          minX: 1,
          minY: 1,
          maxX: 31,
          maxY: 2000,
          gridData: const FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  const FlSpot(1, 89),
                  const FlSpot(2, 1000),
                  const FlSpot(3, 205),
                  const FlSpot(4, 78),
                  const FlSpot(5, 115),
                  const FlSpot(6, 292),
                  const FlSpot(7, 79),
                  const FlSpot(8, 271),
                  const FlSpot(9, 208),
                  const FlSpot(10, 297),
                  const FlSpot(11, 64),
                  const FlSpot(12, 116),
                  const FlSpot(13, 183),
                  const FlSpot(14, 219),
                  const FlSpot(15, 900),
                  const FlSpot(16, 805),
                  const FlSpot(17, 764),
                  const FlSpot(18, 654),
                  const FlSpot(19, 407),
                  const FlSpot(20, 249),
                  const FlSpot(21, 76),
                  const FlSpot(22, 218),
                  const FlSpot(23, 163),
                  const FlSpot(24, 129),
                  const FlSpot(25, 1200),
                  const FlSpot(26, 104),
                  const FlSpot(27, 98),
                  const FlSpot(28, 161),
                  const FlSpot(29, 88),
                  const FlSpot(30, 265),
                  const FlSpot(31, 99)
                  // Add additional FlSpot entries as needed
                ],
                isCurved: true,
                color: kPrimaryColor,
                dotData: const FlDotData(show: false),
                barWidth: 5,
                belowBarData:
                    BarAreaData(show: true, color: kPrimaryColor.withOpacity(0.5))),
          ],
          borderData: FlBorderData(
              show: true, border: Border.all(color: kPrimaryColor, width: 1))),
    );
  }
}
