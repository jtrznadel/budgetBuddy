import 'package:budget_buddy/models/authentication_models/user_registration_model.dart';
import 'package:budget_buddy/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  void registerUser(UserRegistrationModel user) {
    AuthenticationRepository().registerUser(user.toJson());
  }
}
