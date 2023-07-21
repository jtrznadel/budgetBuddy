import 'package:budget_buddy/features/core/models/stats_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constants/color_palette.dart';

class YearlyExpensesLineChartWidget extends StatelessWidget {
  final List<Monthly>? monthlyData; // Nowy parametr przyjmujący dane z monthly

  const YearlyExpensesLineChartWidget({
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

    // Tworzy listę FlSpot z rzeczywistymi danymi monthlyData
    final spots = monthlyData!.asMap().entries.map((entry) {
      final monthIndex = entry.key + 1;
      final totalExpenses = entry.value.totalExpenses ?? 0.0;
      return FlSpot(monthIndex.toDouble(), totalExpenses);
    }).toList();

    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: LineChart(
        LineChartData(
          minX: 1,
          minY: 0,
          maxX: 12, // 12 miesięcy
          maxY: getMaxTotalExpenses(
              monthlyData!), // Fun,kcja pomocnicza do znalezienia maksymalnej wartości wydatków
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: kPrimaryColor,
              dotData: const FlDotData(show: false),
              barWidth: 5,
              belowBarData: BarAreaData(
                show: true,
                color: kPrimaryColor.withOpacity(0.5),
              ),
            ),
          ],
          gridData: const FlGridData(show: false),
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
              leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                reservedSize: 50,
                showTitles: true,
              )),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) => (value >= 0 &&
                              value < monthlyData!.length)
                          ? Text(monthlyData![value.toInt() - 1].month!.substring(0, 3))
                          : Text(
                              monthlyData![value.toInt() - 1].month!.substring(0, 3)))),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))),

          //titlesData: FlTitlesData(bottomTitles: AxisTitles(axisNameWidget: ))
        ),
      ),
    );
  }
}

double getMaxTotalExpenses(List<Monthly> monthlyData) {
  double maxExpenses = 0.0;

  for (var monthlyEntry in monthlyData) {
    if (monthlyEntry.totalExpenses != null && monthlyEntry.totalExpenses! > maxExpenses) {
      maxExpenses = monthlyEntry.totalExpenses!;
    }
  }

  // Dodatkowo, możesz dodać margines do maksymalnej wartości,
  // aby wykres nie był dokładnie na granicy górnej.
  maxExpenses += maxExpenses * 0.1; // 10% margines

  return maxExpenses;
}
