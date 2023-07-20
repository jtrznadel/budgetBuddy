import 'package:budget_buddy/features/core/models/user_model.dart';
import 'package:budget_buddy/repositories/core_repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  final storage = const FlutterSecureStorage();
  var user = Rx<UserModel>(UserModel());

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getUser() async {
    var userId = await getUserId();
    var response = await UserRepository().getUser(userId);
    user.value = response;
  }

  updateUserData(UserModel user) async {
    var userId = await getUserId();
    user.userId = int.parse(userId);
    user.role = "User";
    var response = await UserRepository().updateUserData(user);
    refreshUser();
  }

  void refreshUser() {
    getUser();
    update(); // Wywołanie update() spowoduje, że GetBuilder, Obx itp. zostaną ponownie zbudowane z aktualnymi danymi
  }
}
