import 'package:budget_buddy/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpentWidget extends StatelessWidget {
  const SpentWidget({
    super.key,
    required this.moneySpent,
    required this.totalBalance,
  });

  final double moneySpent;
  final double totalBalance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final spentPercentage = (moneySpent * 100 / totalBalance).round();

    return Container(
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
      height: size.height * 0.18,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'This month spend',
          style: TextStyle(color: kWhiteColor, fontSize: 16),
        ),
        Text(
          '$moneySpent zł',
          style: const TextStyle(color: kWhiteColor, fontSize: 36),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        LinearPercentIndicator(
          lineHeight: 16,
          backgroundColor: kSecondaryColor,
          trailing: Text(
            '$spentPercentage%  ',
            style: const TextStyle(color: kWhiteColor),
          ),
          progressColor: kPrimaryColor,
          percent: moneySpent / totalBalance,
          barRadius: const Radius.circular(100),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        const Text(
          'of total balance',
          style: TextStyle(color: kWhiteColor, fontSize: 16),
        )
      ]),
    );
  }
}
