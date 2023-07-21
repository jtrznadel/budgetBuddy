import 'package:budget_buddy/features/core/models/stats_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constants/color_palette.dart';

class MonthlyExpensesLineChartWidget extends StatelessWidget {
  final List<Daily>? monthlyData; // Nowy parametr przyjmujący dane z daily

  const MonthlyExpensesLineChartWidget({
    this.monthlyData,
    Key? key,
  }) : super(key: key);

  // Reszta widgetu pozostaje bez zmian

  @override
  Widget build(BuildContext context) {
    printError(info: '${monthlyData?.length}');
    if (monthlyData == null || monthlyData!.isEmpty) {
      // Obsługuje przypadki braku danych lub pustej listy
      return const Center(
        child: Text('Brak danych dla wykresu.'),
      );
    }

    // Tworzy listę FlSpot z rzeczywistymi danymi dailyData
    final spots = monthlyData!.asMap().entries.map((entry) {
      final dayIndex = entry.key + 1;
      final totalExpenses = entry.value.totalExpenses ?? 0.0;
      return FlSpot(dayIndex.toDouble(), totalExpenses);
    }).toList();

    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: LineChart(
        LineChartData(
          minX: 1,
          minY: 0,
          maxX: 31, // Set the maxX value to the number of days in the month
          maxY: getMaxTotalExpenses(
              monthlyData!), // Funkcja pomocnicza do znalezienia maksymalnej wartości wydatków
          gridData: const FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: kPrimaryColor,
              dotData: const FlDotData(show: false),
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: kPrimaryColor.withOpacity(0.5),
              ),
            ),
          ],
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Color(0xff37434d), width: 2),
              bottom: BorderSide(color: Color(0xff37434d), width: 2),
              top: BorderSide(color: Colors.transparent),
              right: BorderSide(color: Colors.transparent),
            ),
          ),
          titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) =>
                          value == 31 ? const Text('') : Text('${value.round()}'))),
              leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                reservedSize: 50,
                showTitles: true,
              )),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))),
        ),
      ),
    );
  }
}

double getMaxTotalExpenses(List<Daily> monthlyData) {
  double maxExpenses = 0.0;

  for (var dailyEntry in monthlyData) {
    if (dailyEntry.totalExpenses != null && dailyEntry.totalExpenses! > maxExpenses) {
      maxExpenses = dailyEntry.totalExpenses!;
    }
  }

  // Dodatkowo, możemy dodać margines do maksymalnej wartości,
  // aby wykres nie był dokładnie na granicy górnej.
  maxExpenses += maxExpenses * 0.1; // 10% margines

  // Jeśli maxExpenses jest mniejsze lub równe 0, zwracamy 1.
  // W ten sposób unikniemy sytuacji, gdy wykres wychodzi poniżej 0.
  return maxExpenses <= 0 ? 1 : maxExpenses;
}
