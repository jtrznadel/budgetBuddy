import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  bool isPasswordObscured = true;

  final email = TextEditingController();
  final password = TextEditingController();
}
