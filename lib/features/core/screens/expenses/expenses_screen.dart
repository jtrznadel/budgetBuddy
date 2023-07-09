import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/features/core/screens/dashboard/widgets/expense_widget.dart';
import 'package:budget_buddy/features/core/screens/expenses/widgets/category_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ExpensesController());
    final size = MediaQuery.of(context).size;
    Future<void> refreshExpenses() async {}
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 10),
      color: kSecondaryColor,
      child: Column(children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: kTertiaryColor,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                CategoryButtonWidget(
                  id: 1,
                ),
                CategoryButtonWidget(
                  id: 2,
                ),
                CategoryButtonWidget(
                  id: 3,
                ),
                CategoryButtonWidget(
                  id: 4,
                ),
                CategoryButtonWidget(
                  id: 5,
                ),
                CategoryButtonWidget(
                  id: 6,
                ),
              ]),
            )),
        SizedBox(
          height: size.height * 0.02,
        ),
        Expanded(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.white,
                  Colors.white,
                  Colors.white.withOpacity(0.05)
                ],
                stops: const [0, 0.05, 0.95, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: RefreshIndicator(
              onRefresh: refreshExpenses,
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.selectedExpenses.length,
                  itemBuilder: (context, int index) {
                    final ExpenseModel expense = controller.selectedExpenses[index];

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
        ),
      ]),
    );
  }
}
