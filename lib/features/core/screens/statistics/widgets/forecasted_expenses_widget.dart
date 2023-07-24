import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/models/forecast_model.dart';
import 'package:flutter/material.dart';

class ForecastedExpensesWidget extends StatelessWidget {
  final List<ForecastModel> list;
  final int index;
  final List<double> period;
  const ForecastedExpensesWidget({
    super.key,
    required this.list,
    required this.index,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double average = list[index].average ?? 0.0;
    double totalOfPeriod = period[index] ?? 0.0;

    Icon iconData;
    if (average < totalOfPeriod) {
      iconData = const Icon(
        Icons.keyboard_double_arrow_down_rounded,
        color: Colors.green,
        size: 24,
      );
    } else {
      iconData = const Icon(
        Icons.keyboard_double_arrow_up_rounded,
        color: Colors.red,
        size: 24,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),
        const Text(
          'Upcoming expenses forecast',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ],
              borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          height: size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index == 0
                    ? '${list[0].lowerBound!.toStringAsFixed(2)} - ${list[0].upperBound!.toStringAsFixed(2)}zł'
                    : index == 1
                        ? '${list[1].lowerBound!.toStringAsFixed(2)} - ${list[1].upperBound!.toStringAsFixed(2)}zł'
                        : '${list[2].lowerBound!.toStringAsFixed(2)} - ${list[2].upperBound!.toStringAsFixed(2)}zł',
                style: const TextStyle(fontSize: 18, color: kWhiteColor),
              ),
              iconData
            ],
          ),
        ),
      ],
    );
  }
}
