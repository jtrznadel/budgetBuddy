import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/features/core/screens/dashboard/widgets/expense_widget.dart';
import 'package:budget_buddy/features/core/screens/expenses/widgets/category_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoriesController = Get.put(CategoriesController());
    var expensesController = Get.put(ExpensesController());
    final size = MediaQuery.of(context).size;
    Future<void> refreshExpenses() async {}

    return Container(
      padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 10),
      color: kSecondaryColor,
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: kTertiaryColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesController.categories.length,
                  itemBuilder: (context, int index1) {
                    final CategoryModel category =
                        categoriesController.categories[index1];
                    return CategoryButtonWidget(id: category.categoryId!);
                  },
                ),
              )),
          const SizedBox(
            height: kDefaultPadding, // Add some spacing between the two containers
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white,
                    Colors.white,
                    Colors.white.withOpacity(0.05),
                  ],
                  stops: const [0, 0.05, 0.95, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: expensesController.selectedExpenses.length,
                  itemBuilder: (context, int index) {
                    final ExpenseModel expense =
                        expensesController.selectedExpenses[index];
                    return Column(
                      children: [
                        ExpenseWidget(expense: expense),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
