import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpensesController());
    return Container(
        margin: const EdgeInsets.all(3).copyWith(right: 0),
        height: 60,
        width: 60,
        child: RawMaterialButton(
          onPressed: () {
            controller.getSelectedExpenses(id);
          },
          elevation: 4,
          fillColor: kTertiaryColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.heart_broken_outlined,
            size: 26,
          ),
        ));
  }
}
