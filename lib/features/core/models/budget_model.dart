// To parse this JSON data, do
//
//     final budgetModel = budgetModelFromJson(jsonString);

import 'dart:convert';

BudgetModel budgetModelFromJson(String str) => BudgetModel.fromJson(json.decode(str));

String budgetModelToJson(BudgetModel data) => json.encode(data.toJson());

class BudgetModel {
  int? budgetId;
  int? userId;
  dynamic user;
  DateTime? startDate;
  DateTime? endDate;
  int? budgetLimit;
  double? budgetSpent;
  double? budgetRemaining;

  BudgetModel({
    this.budgetId,
    this.userId,
    this.user,
    this.startDate,
    this.endDate,
    this.budgetLimit,
    this.budgetSpent,
    this.budgetRemaining,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
        budgetId: json["budgetId"],
        userId: json["userId"],
        user: json["user"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        budgetLimit: json["budgetLimit"],
        budgetSpent: json["budgetSpent"]?.toDouble(),
        budgetRemaining: json["budgetRemaining"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "budgetId": budgetId,
        "userId": userId,
        "user": user,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "budgetLimit": budgetLimit,
        "budgetSpent": budgetSpent,
        "budgetRemaining": budgetRemaining,
      };
}
