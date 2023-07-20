import 'package:budget_buddy/common_widgets/controllers/navigation_profile_controller.dart';
import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/controllers/budget_controller.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/controllers/expenses_controller.dart';
import 'package:budget_buddy/features/core/controllers/stats_controller.dart';
import 'package:budget_buddy/features/core/controllers/user_controller.dart';
import 'package:budget_buddy/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:budget_buddy/features/core/screens/expenses/expenses_screen.dart';
import 'package:budget_buddy/features/core/screens/goals/goals_screen.dart';
import 'package:budget_buddy/features/core/screens/profile/profile_screen.dart';
import 'package:budget_buddy/features/core/screens/statistics/statistics_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationProfile extends StatelessWidget {
  final NavigationProfileController controller = Get.put(NavigationProfileController());
  final expensesController = Get.put(ExpensesController());
  final userController = Get.put(UserController());
  final budgetController = Get.put(BudgetController());
  final statsController = Get.put(StatsController());
  final categoriesController = Get.put(CategoriesController());

  final List<Widget> screens = [
    const GoalsScreen(),
    const ExpensesScreen(),
    DashboardScreen(),
    const StatisticsScreen(),
    const ProfileScreen(),
  ];

  final List<Widget> items = [
    const Icon(
      Icons.flag_outlined,
      size: 32,
      color: kWhiteColor,
    ),
    const Icon(
      Icons.payment_outlined,
      size: 32,
      color: kWhiteColor,
    ),
    const Icon(
      Icons.home_outlined,
      size: 32,
      color: kWhiteColor,
    ),
    const Icon(
      Icons.trending_up_rounded,
      size: 32,
      color: kWhiteColor,
    ),
    const Icon(
      Icons.account_circle_outlined,
      size: 32,
      color: kWhiteColor,
    ),
  ];

  final List<String> barTitles = [
    'Your Goals',
    'Your Expenses',
    'Dashboard',
    'Analytics',
    'My Profile',
  ];

  NavigationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    userController.getUser();
    categoriesController.getCategories();
    expensesController.getExpenses();
    budgetController.getBudget();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => Text(
              barTitles[controller.currentIndex.value],
              style: const TextStyle(color: kPrimaryColor, fontSize: 18),
            )),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        elevation: 0,
      ),
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: GetBuilder<NavigationProfileController>(
        builder: (controller) => CurvedNavigationBar(
          animationCurve: Curves.easeInOutCubic,
          index: controller.currentIndex.value,
          backgroundColor: kSecondaryColor,
          color: kPrimaryColor,
          height: 60,
          items: items,
          onTap: (index) {
            controller.changePage(index); // Zmiana strony
            // Odświeżanie danych dla odpowiedniego kontrolera po zmianie strony
            if (index == 0) {
            } else if (index == 1) {
              expensesController.refreshExpenses();
              categoriesController.refreshCategories();
            } else if (index == 2) {
              userController.refreshUser();
              budgetController.refreshBudget();
            } else if (index == 3) {
              statsController.refreshStats();
            } else if (index == 4) {
              userController.refreshUser();
            }
          },
        ),
      ),
    );
  }
}
