import 'package:budget_buddy/features/core/models/user_model.dart';
import 'package:budget_buddy/repositories/core_repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    getStats();
    super.onInit();
  }

  final storage = const FlutterSecureStorage();
  var user = UserModel();

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getStats() async {
    var userId = await getUserId();
    var response = await UserRepository().getUser(userId);
    user = response;
  }
}
