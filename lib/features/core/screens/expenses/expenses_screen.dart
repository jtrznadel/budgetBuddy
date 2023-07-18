import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:budget_buddy/features/core/screens/dashboard/widgets/expense_widget.dart';
import 'package:budget_buddy/features/core/screens/expenses/widgets/category_button_widget.dart';
import 'package:budget_buddy/features/core/screens/expenses/widgets/add_expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    var categoriesController = Get.put(CategoriesController());
    var expensesController = Get.put(ExpensesController());
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(15).copyWith(top: 10, bottom: kDefaultPadding),
      color: kSecondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
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
                          return CategoryButtonWidget(
                            id: category.categoryId!,
                            icon: int.parse(category.icon!),
                            color: category.color!,
                          );
                        },
                      ),
                    )),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: kTertiaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                expensesController.selectedDate.value =
                                    selectedDate.toString().split(' ')[0];
                                expensesController.getSelectedExpenses();
                              }
                            });
                          },
                          elevation: 4,
                          fillColor: kTertiaryColor,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.calendar_month_outlined,
                            size: 26,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 5, // Add some spacing between the two containers
          ),
          Obx(
            () => expensesController.selectedDate.value.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      expensesController.selectedDate.value = '';
                      expensesController.getSelectedExpenses();
                    },
                    child: UnconstrainedBox(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: kTertiaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Row(
                          children: [
                            Text(expensesController.selectedDate.value),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {
                                expensesController.selectedDate.value = '';
                                expensesController.getSelectedExpenses();
                              },
                              icon: const Icon(Icons.cancel),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
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
                () => expensesController.selectedExpenses.isEmpty
                    ? Opacity(
                        opacity: 0.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/notFoundImage.svg',
                                height: size.height * 0.3,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'You didn\'t incur any expenses on that day',
                                style:
                                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: expensesController.selectedExpenses.length,
                        itemBuilder: (context, int index) {
                          ExpenseModel expense =
                              expensesController.selectedExpenses[index];
                          var category = categoriesController.categories
                              .where((c) => c.categoryId == expense.categoryId)
                              .first;
                          return Column(
                            children: [
                              ExpenseWidget(
                                  expense: expense, icon: int.parse(category.icon!)),
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
          const ExpenseModalWidget()
        ],
      ),
    );
  }
}
