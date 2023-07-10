import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:budget_buddy/repositories/core_repository/categories_repository.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  @override
  void onReady() {
    getCategories();
    super.onReady();
  }

  var categories = RxList<CategoryModel>();

  getCategories() async {
    var response = await CategoriesRepository().getCategories();
    categories.value = response;
  }
}
