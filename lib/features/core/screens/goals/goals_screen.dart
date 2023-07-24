import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/goal_controller.dart';
import 'package:budget_buddy/features/core/models/goal_model.dart';
import 'package:budget_buddy/features/core/screens/goals/widgets/add_goal_modal.dart';
import 'package:budget_buddy/features/core/screens/goals/widgets/goal_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goalsController = Get.put(GoalController());
    goalsController.getGoals();
    final size = MediaQuery.of(context).size;

    final TextEditingController goalNameController = TextEditingController();
    final TextEditingController goalAmountController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: goalsController
                      .goals.length, // Change this to goalsController.goals.length
                  itemBuilder: (context, int index) {
                    GoalModel goal = goalsController.goals[index];
                    return Column(
                      children: [
                        GoalWidget(goal: goal),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const AddGoalModal(),
                );
              },
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
