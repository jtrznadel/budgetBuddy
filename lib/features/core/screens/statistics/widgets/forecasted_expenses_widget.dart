import 'package:budget_buddy/constants/color_palette.dart';
import 'package:flutter/material.dart';

class ForecastedExpensesWidget extends StatelessWidget {
  final List<dynamic> list;
  final int index;
  const ForecastedExpensesWidget({
    super.key,
    required this.list,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 10,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming expenses forecast',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                index == 0
                    ? '${list[0].toStringAsFixed(2)} zł'
                    : index == 1
                        ? '${list[1].toStringAsFixed(2)} zł'
                        : '${list[2].toStringAsFixed(2)} zł',
                style: const TextStyle(fontSize: 18, color: kWhiteColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
