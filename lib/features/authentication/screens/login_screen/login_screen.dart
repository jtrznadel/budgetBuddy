import 'package:budget_buddy/common_widgets/form/form_header_widget.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/screens/login_screen/widgets/login_footer_widget.dart';
import 'package:budget_buddy/features/authentication/screens/login_screen/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FormHeaderWidget(
            image: 'assets/images/loginImage.svg',
            title: 'Glad to see You again!',
            subTitle:
                'Take control of your finances with budgetBuddy - budgeting made simple.',
            imageScale: 0.3,
          ),
          LoginForm(),
          LoginFooterWidget()
        ]),
      )),
    );
  }
}
