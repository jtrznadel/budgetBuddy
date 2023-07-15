import 'package:budget_buddy/common_widgets/navigation/navigation_profile_widget.dart';
import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/features/authentication/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../../constants/sizes.dart';

import '../login_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

const storage = FlutterSecureStorage();

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put((LogInController()));
    final formKey = GlobalKey<FormState>();
    return Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter e-mail.';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline_outlined,
                  ),
                  labelText: "E-Mail",
                ),
              ),
              const SizedBox(
                height: kDefaultPadding - 15,
              ),
              TextFormField(
                controller: controller.password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password.';
                  } else {
                    return null;
                  }
                },
                obscureText: controller.isPasswordObscured,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.fingerprint_outlined,
                  ),
                  labelText: "Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isPasswordObscured = !controller.isPasswordObscured;
                      });
                    },
                    child: Icon(controller.isPasswordObscured
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: kDefaultPadding - 20,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => const LoginScreen());
                      },
                      style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                      child: const Text("Forgot Password?"))),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var result = await LogInController.instance.loginUser(
                          controller.email.text.trim(), controller.password.text.trim());
                      if (result == true) {
                        Get.to(() => const NavigationProfile());
                      }
                    }
                  },
                  child: const Text("Login"),
                ),
              )
            ],
          ),
        ));
  }
}
