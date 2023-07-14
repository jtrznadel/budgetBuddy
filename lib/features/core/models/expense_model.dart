// To parse this JSON data, do
//
//     final expenseModel = expenseModelFromJson(jsonString);

import 'dart:convert';

List<ExpenseModel> expenseModelFromJson(String str) =>
    List<ExpenseModel>.from(json.decode(str).map((x) => ExpenseModel.fromJson(x)));

String expenseModelToJson(List<ExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseModel {
  int? expenseId;
  String? name;
  String? description;
  double? price;
  DateTime? date;
  int? userId;
  int? categoryId;
  dynamic category;

  ExpenseModel({
    this.expenseId,
    this.name,
    this.description,
    this.price,
    this.date,
    this.userId,
    this.categoryId,
    this.category,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        expenseId: json["expenseId"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        userId: json["userId"],
        categoryId: json["categoryId"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "expenseId": expenseId,
        "name": name,
        "description": description,
        "price": price,
        "date": date?.toIso8601String(),
        "userId": userId,
        "categoryId": categoryId,
        "category": category,
      };
}
