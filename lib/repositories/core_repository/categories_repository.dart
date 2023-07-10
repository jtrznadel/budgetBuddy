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
}
