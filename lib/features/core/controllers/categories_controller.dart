import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:budget_buddy/repositories/core_repository/categories_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  @override
  void onInit() {
    getCategories();
    getUserCategories();

    super.onInit();
  }

  var categories = RxList<CategoryModel>();
  var userCategories = RxList<CategoryModel>();
  final storage = const FlutterSecureStorage();

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getCategories() async {
    var response = await CategoriesRepository().getCategories();
    categories.value = response;
  }

  getUserCategories() async {
    var userId = await getUserId();
    var response = await CategoriesRepository().getUserCategories(userId);
    userCategories.value = response;
  }

  getCategoryById(int id) async {
    var response = await CategoriesRepository().getCategoryById(id);
    return response;
  }

  addCategory(CategoryModel category) async {
    var userId = await getUserId();
    category.userId = int.parse(userId);
    category.color = "string";
    try {
      var addedCategory = await CategoriesRepository().addCategory(category);
      userCategories.add(addedCategory);
    } catch (error) {
      printError(info: 'Error adding category: $error');
    }
    refreshCategories();
  }

  updateCategory(CategoryModel category) async {
    var response = await CategoriesRepository().updateCategory(category);
    refreshCategories();
  }

  refreshCategories() {
    getCategories();
    getUserCategories();
    update(); // Wywołanie update() spowoduje, że GetBuilder, Obx itp. zostaną ponownie zbudowane z aktualnymi danymi
  }
}
