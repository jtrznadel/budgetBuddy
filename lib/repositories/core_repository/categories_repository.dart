import 'dart:convert';

import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:dio/dio.dart';

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
      throw e.response!.data;
    }
  }
}
