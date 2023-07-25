import 'dart:convert';

import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../auth/secrets.dart';

class CategoriesRepository {
  final Dio _dio = Dio();

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await _dio.get('$apiAdress/Categories');
      if (response.statusCode == 200) {
        var jsonData = response.data as List<dynamic>;
        var categories = categoryModelFromJson(json.encode(jsonData));
        return categories;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      throw e.response!.data;
    }
  }

  Future<List<CategoryModel>> getUserCategories(String userId) async {
    try {
      var response = await _dio.get('$apiAdress/Categories/GetUserCategories',
          queryParameters: {"id": userId});
      if (response.statusCode == 200) {
        var jsonData = response.data as List<dynamic>;
        if (jsonData.isNotEmpty) {
          var categories = categoryModelFromJson(json.encode(jsonData));
          return categories;
        }
        return [];
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      throw e.response!.data;
    }
  }

  Future<CategoryModel> addCategory(CategoryModel category) async {
    try {
      var response = await _dio.post(
        '$apiAdress/Categories',
        data: {
          'name': category.name,
          'icon': category.icon,
          'color': category.color,
          'userId': category.userId
        },
      );
      if (response.statusCode == 201) {
        var jsonData = response.data;
        var addedCategory = CategoryModel.fromJson(jsonData);
        return addedCategory;
      }
      throw response.data.statusCode;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      throw e.response!.data;
    }
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    try {
      var response = await _dio.get('$apiAdress/Categories/$id');

      var jsonData = response.data;
      var category = CategoryModel.fromJson(jsonData);
      return category;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      throw e.response!.data;
    }
  }

  Future<int> updateCategory(CategoryModel category) async {
    try {
      var response =
          await _dio.put('$apiAdress/Categories/${category.categoryId}', data: {
        "categoryId": category.categoryId,
        "name": category.name,
        "icon": category.icon,
        "color": category.color,
        "userId": category.userId,
      });

      return response.statusCode!;
    } on DioException catch (e) {
      Get.snackbar("Error", "Something went wrong!");
      if (e.response != null) {
        return e.response!.statusCode ?? 500;
      } else {
        return 500;
      }
    }
  }
}
