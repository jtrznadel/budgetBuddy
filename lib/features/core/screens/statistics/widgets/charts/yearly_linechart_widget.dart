import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/color_palette.dart';

class YearlyExpensesLineChartWidget extends StatelessWidget {
  const YearlyExpensesLineChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          minX: 1,
          minY: 1,
          maxX: 12,
          maxY: 2000,
          gridData: const FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  const FlSpot(1, 89),
                  const FlSpot(2, 157),
                  const FlSpot(3, 205),
                  const FlSpot(4, 78),
                  const FlSpot(5, 115),
                  const FlSpot(6, 292),
                  const FlSpot(7, 1154),
                  const FlSpot(8, 271),
                  const FlSpot(9, 208),
                  const FlSpot(10, 297),
                  const FlSpot(11, 64),
                  const FlSpot(12, 116),
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
