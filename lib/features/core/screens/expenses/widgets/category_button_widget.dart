import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
    Key? key,
    required this.id,
    required this.color,
    required this.icon,
  }) : super(key: key);

  final int id;
  final String color;
  final int icon;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExpensesController>();

    return SizedBox(
      width: 60,
      child: RawMaterialButton(
        onPressed: () {
          controller.setSelectedCategory(id);
          controller.getSelectedExpenses();
        },
        elevation: 4,
        fillColor:
            controller.selectedCategory.value != id ? kTertiaryColor : kPrimaryColor,
        shape: const CircleBorder(),
        child: Icon(
          IconData(icon, fontFamily: 'MaterialIcons'),
          size: 26,
        ),
      ),
    );
  }
}
