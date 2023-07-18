import 'package:budget_buddy/features/core/models/stats_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constants/color_palette.dart';

class WeeklyExpensesLineChartWidget extends StatelessWidget {
  final List<Daily>? dailyData; // Nowy parametr przyjmujący dane z daily

  const WeeklyExpensesLineChartWidget({
    this.dailyData,
    Key? key,
  }) : super(key: key);

  // Reszta widgetu pozostaje bez zmian

  @override
  Widget build(BuildContext context) {
    printError(info: '${dailyData?.length}');
    if (dailyData == null || dailyData!.isEmpty) {
      // Obsługuje przypadki braku danych lub pustej listy
      return const Center(
        child: Text('Brak danych dla wykresu.'),
      );
    }

    // Tworzy listę FlSpot z rzeczywistymi danymi dailyData
    final spots = dailyData!.asMap().entries.map((entry) {
      final dayIndex = entry.key + 1;
      final totalExpenses = entry.value.totalExpenses ?? 0.0;
      return FlSpot(dayIndex.toDouble(), totalExpenses);
    }).toList();

    return LineChart(
      LineChartData(
        minX: 1,
        minY: 0,
        maxX: dailyData!.length.toDouble(),
        maxY: getMaxTotalExpenses(
            dailyData!), // Funkcja pomocnicza do znalezienia maksymalnej wartości wydatków
        gridData: const FlGridData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: kPrimaryColor,
            dotData: const FlDotData(show: false),
            barWidth: 5,
            belowBarData: BarAreaData(
              show: true,
              color: kPrimaryColor.withOpacity(0.5),
            ),
          ),
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: kPrimaryColor, width: 1),
        ),
      ),
    );
  }
}

double getMaxTotalExpenses(List<Daily> dailyData) {
  double maxExpenses = 0.0;

  for (var dailyEntry in dailyData) {
    if (dailyEntry.totalExpenses != null && dailyEntry.totalExpenses! > maxExpenses) {
      maxExpenses = dailyEntry.totalExpenses!;
    }
  }

  // Dodatkowo, możesz dodać margines do maksymalnej wartości,
  // aby wykres nie był dokładnie na granicy górnej.
  maxExpenses += maxExpenses * 0.1; // 10% margines

  return maxExpenses;
}
