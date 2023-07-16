import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/screens/expenses/widgets/category_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseAddButtonAndFormWidget extends StatelessWidget {
  const ExpenseAddButtonAndFormWidget({
    super.key,
  });

  void _showAddExpenseModal(BuildContext context) {
    var categoriesController = Get.put(CategoriesController());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
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
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Expense Name',
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Expense Amount',
                  ),
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
                  child: Row(
                    children: categoriesController.categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            CategoryButtonWidget(
                              id: category.categoryId!,
                              icon: int.parse(category.icon!),
                              color: category.color!,
                            ),
                            Text(category.name.toString())
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Obsługa dodawania wydatku
                  },
                  child: const Text('Add Expense'),
                ),
              ],
            ),
          ),
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
