import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/controllers/signup_controller.dart';
import 'package:budget_buddy/models/authentication_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding - 15),
      child: Form(
        key: formKey,
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
                label: Text("Email"),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: kDefaultPadding - 20),
            TextFormField(
              controller: controller.firstName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name.';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                label: Text("First Name"),
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: kDefaultPadding - 20),
            TextFormField(
              controller: controller.lastName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter last name.';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                label: Text("Last Name"),
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: kDefaultPadding - 20),
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
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                label: const Text("Password"),
                prefixIcon: const Icon(Icons.fingerprint_outlined),
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
            const SizedBox(height: kDefaultPadding - 20),
            TextFormField(
              controller: controller.confirmPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm password.';
                } else {
                  return null;
                }
              },
              obscureText: controller.isConfirmPasswordObscured,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                label: const Text("Confirm Password"),
                prefixIcon: const Icon(Icons.fingerprint_outlined),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.isConfirmPasswordObscured =
                          !controller.isConfirmPasswordObscured;
                    });
                  },
                  child: Icon(controller.isConfirmPasswordObscured
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    SignUpController.instance.registerUser(UserModel(
                      email: controller.email.text.trim(),
                      firstName: controller.firstName.text.trim(),
                      lastName: controller.lastName.text.trim(),
                      password: controller.password.text.trim(),
                      confirmPassword: controller.confirmPassword.text.trim(),
                    ));
                  }
                },
                child: const Text("Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
