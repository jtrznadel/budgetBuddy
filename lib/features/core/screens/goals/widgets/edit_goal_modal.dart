import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/goal_controller.dart';
import 'package:budget_buddy/features/core/models/goal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditGoalModal extends StatefulWidget {
  final GoalModel goal;

  const EditGoalModal({required this.goal, Key? key}) : super(key: key);

  @override
  State<EditGoalModal> createState() => _EditGoalModalState();
}

class _EditGoalModalState extends State<EditGoalModal> {
  DateTime selectedDate = DateTime.now();
  int selectedIcon = 0;
  final goalNameController = TextEditingController();
  final goalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the existing goal data
    goalNameController.text = widget.goal.name!;
    goalAmountController.text = widget.goal.goalAmount.toString();
    selectedDate = widget.goal.deadline!;
    selectedIcon = int.parse(widget.goal.icon!);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    goalNameController.dispose();
    goalAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goalController = Get.find<GoalController>();
    List<int> icons = [0xeec6, 0xe1d2, 0xefc5, 0xef2d, 0xe185];

    return Container(
      padding: const EdgeInsets.all(kDefaultPadding)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Edit Goal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: goalNameController,
            decoration: const InputDecoration(
              labelText: 'Goal Name',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: goalAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Target Amount',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    ).then((date) {
                      if (date != null && date != selectedDate) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 5),
                      Text(
                        'Select Deadline: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Selected Icon',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    IconData(selectedIcon, fontFamily: 'MaterialIcons'),
                    size: 32,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Select one of the icons below:'),
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5,
              children: List.generate(icons.length, (index) {
                return IconButton(
                  icon: Icon(IconData(icons[index], fontFamily: 'MaterialIcons')),
                  onPressed: () {
                    setState(() {
                      selectedIcon = icons[index];
                    });
                  },
                );
              }),
            ),
          ),
          const SizedBox(
              height: 20), // Add some spacing between the button and the content
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                String goalName = goalNameController.text.trim();
                double goalAmount =
                    double.tryParse(goalAmountController.text.trim()) ?? 0.0;
                GoalModel editedGoal = GoalModel(
                  id: widget.goal.id,
                  name: goalName,
                  icon: selectedIcon.toString(),
                  goalAmount: goalAmount,
                  deadline: selectedDate,
                  actualAmount: widget.goal.actualAmount,
                );
                goalController.updateGoal(editedGoal);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Make the button more rounded
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16), // Add some vertical padding
              ),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
