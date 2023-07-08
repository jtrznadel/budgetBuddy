import 'package:budget_buddy/common_widgets/form/form_header_widget.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/signup_footer_widget.dart';
import 'widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => const WelcomeScreen()),
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
              title: 'Find your own .buddy!',
              subTitle:
                  'Discover your financial ally and embark on a journey to financial success.',
              imageScale: 0.15,
            ),
            SignUpFormWidget(),
            SignUpFooterWidget(),
          ]),
        ),
      ),
    );
  }
}
