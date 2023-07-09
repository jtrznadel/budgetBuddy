import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/screens/dashboard/widgets/expense_widget.dart';
import 'package:budget_buddy/features/core/screens/dashboard/widgets/spent_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ExpensesController());
    const double moneySpent = 2443.54;
    const double totalBalance = 5000.00;
    final size = MediaQuery.of(context).size;

    Future<void> refreshExpenses() async {
      await controller.getExpenses();
    }

    return Container(
        color: kSecondaryColor,
        padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Hello, \n', style: TextStyle(fontSize: 18, color: Colors.black)),
              TextSpan(
                  text: 'Andrew',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, color: kPrimaryColor))
            ])),
            SizedBox(
              height: size.height * 0.01,
            ),
            const SpentWidget(moneySpent: moneySpent, totalBalance: totalBalance),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Text(
                    'Latest Expenses',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
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
                            itemCount: controller.expenses.length,
                            itemBuilder: (context, int index) {
                              final expense = controller.expenses[index];
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
                ],
              ),
            )
          ],
        ));
  }
}
