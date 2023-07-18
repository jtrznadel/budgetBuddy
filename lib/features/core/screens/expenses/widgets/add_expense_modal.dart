import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:budget_buddy/features/core/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseModalWidget extends StatefulWidget {
  const ExpenseModalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpenseModalWidget> createState() => _ExpenseModalWidgetState();
}

class _ExpenseModalWidgetState extends State<ExpenseModalWidget> {
  late CategoriesController categoriesController;
  late ExpensesController expensesController;
  late CategoryModel selectedCategory;

  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoriesController = Get.find<CategoriesController>();
    expensesController = Get.find<ExpensesController>();
    selectedCategory = categoriesController.categories[0];
  }

  void _showAddExpenseModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add New Expense',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: expenseNameController,
                      decoration: const InputDecoration(
                        labelText: 'Expense Name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: expenseAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Expense Amount',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Category',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Icon(
                              IconData(int.parse(selectedCategory.icon!),
                                  fontFamily: 'MaterialIcons'),
                              size: 32,
                            ),
                            Text('${selectedCategory.name}')
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Category:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<CategoriesController>(
                        builder: (controller) {
                          return Row(
                            children: categoriesController.categories.map((category) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = category;
                                      });
                                    },
                                    child: TextButton.icon(
                                      label: Text(category.name.toString()),
                                      icon: Icon(IconData(int.parse(category.icon!),
                                          fontFamily: 'MaterialIcons')),
                                      onPressed: () {
                                        setState(() {
                                          selectedCategory = category;
                                        });
                                      },
                                    )),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        String expenseName = expenseNameController.text.trim();
                        String expenseAmount = expenseAmountController.text.trim();
                        ExpenseModel expense = ExpenseModel(
                            name: expenseName,
                            price: double.parse(expenseAmount),
                            categoryId: selectedCategory.categoryId);
                        expensesController.addExpense(expense);
                        Navigator.pop(context);
                      },
                      child: const Text('Add Expense'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          _showAddExpenseModal(context);
        },
        label: const Text('Add New Expense'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
