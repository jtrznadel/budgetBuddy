import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateBudgetLimitModal extends StatelessWidget {
  const UpdateBudgetLimitModal({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    final TextEditingController budgetLimitController =
        TextEditingController(text: budgetController.budget.value.budgetLimit.toString());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Close the keyboard when tapping outside the text field
      },
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: budgetLimitController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'New Budget Limit'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double newBudgetLimit =
                    double.tryParse(budgetLimitController.text) ?? 0.0;
                budgetController.updateBudget(newBudgetLimit);
                Navigator.of(context).pop(); // Close the modal bottom sheet
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
