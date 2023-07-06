import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:budget_buddy/features/core/screens/expenses/expenses_screen.dart';
import 'package:budget_buddy/features/core/screens/group_expenses/group_expenses_screen.dart';
import 'package:budget_buddy/features/core/screens/profile/profile_screen.dart';
import 'package:budget_buddy/features/core/screens/statistics/statistics_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavigationProfile extends StatefulWidget {
  const NavigationProfile({super.key});
  @override
  State<NavigationProfile> createState() => _NavigationProfile();
}

final items = [
  const Icon(
    Icons.people_alt_outlined,
    size: 32,
    color: kWhiteColor,
  ),
  const Icon(
    Icons.monetization_on_outlined,
    size: 32,
    color: kWhiteColor,
  ),
  const Icon(
    Icons.home_outlined,
    size: 32,
    color: kWhiteColor,
  ),
  const Icon(
    Icons.stacked_line_chart_rounded,
    size: 32,
    color: kWhiteColor,
  ),
  const Icon(
    Icons.account_circle_outlined,
    size: 32,
    color: kWhiteColor,
  ),
];

final screens = [
  const GroupExpensesScreen(),
  const ExpensesScreen(),
  const DashboardScreen(),
  const StatisticsScreen(),
  const ProfileScreen(),
];

class _NavigationProfile extends State<NavigationProfile> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('.budgetBuddy',
              style: TextStyle(color: kPrimaryColor, fontSize: 24)),
          centerTitle: true,
          backgroundColor: kSecondaryColor,
          elevation: 0,
        ),
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          key: navigationKey,
          animationCurve: Curves.easeInOutCubic,
          index: index,
          backgroundColor: kSecondaryColor,
          color: kPrimaryColor,
          height: 60,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
