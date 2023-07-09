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
  int? categoryId;
  dynamic category;
  int? userId;
  dynamic user;

  ExpenseModel({
    this.expenseId,
    this.name,
    this.description,
    this.price,
    this.date,
    this.categoryId,
    this.category,
    this.userId,
    this.user,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        expenseId: json["expenseId"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        categoryId: json["categoryId"],
        category: json["category"],
        userId: json["userId"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "expenseId": expenseId,
        "name": name,
        "description": description,
        "price": price,
        "date": date?.toIso8601String(),
        "categoryId": categoryId,
        "category": category,
        "userId": userId,
        "user": user,
      };
}
