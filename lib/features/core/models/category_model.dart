// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int? categoryId;
  String? name;
  String? icon;
  String? color;
  int? userId;

  CategoryModel({
    this.categoryId,
    this.name,
    this.icon,
    this.color,
    this.userId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["categoryId"],
        name: json["name"],
        icon: json["icon"],
        color: json["color"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "icon": icon,
        "color": color,
        "userId": userId,
      };
}
