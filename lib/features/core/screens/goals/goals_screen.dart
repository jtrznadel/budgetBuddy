import 'package:budget_buddy/constants/color_palette.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: kSecondaryColor,
        body: Column(
          children: [Text('Goals')],
        ));
  }
}
