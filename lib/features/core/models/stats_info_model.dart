// To parse this JSON data, do
//
//     final statsInfoModel = statsInfoModelFromJson(jsonString);

import 'dart:convert';

StatsInfoModel statsInfoModelFromJson(String str) =>
    StatsInfoModel.fromJson(json.decode(str));

String statsInfoModelToJson(StatsInfoModel data) => json.encode(data.toJson());

class StatsInfoModel {
  String? period;
  DateTime? startDate;
  DateTime? endDate;
  LeastSpentCategory? mostSpentCategory;
  LeastSpentCategory? mostFrequentCategory;
  LeastSpentCategory? leastSpentCategory;
  List<LeastSpentCategory>? categoriesWithNoExpenses;
  double? totalExpensesForPeriod;
  List<LeastSpentCategory>? categoryExpensesForPeriod;

  StatsInfoModel({
    this.period,
    this.startDate,
    this.endDate,
    this.mostSpentCategory,
    this.mostFrequentCategory,
    this.leastSpentCategory,
    this.categoriesWithNoExpenses,
    this.totalExpensesForPeriod,
    this.categoryExpensesForPeriod,
  });

  factory StatsInfoModel.fromJson(Map<String, dynamic> json) => StatsInfoModel(
        period: json["period"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        mostSpentCategory: json["mostSpentCategory"] == null
            ? null
            : LeastSpentCategory.fromJson(json["mostSpentCategory"]),
        mostFrequentCategory: json["mostFrequentCategory"] == null
            ? null
            : LeastSpentCategory.fromJson(json["mostFrequentCategory"]),
        leastSpentCategory: json["leastSpentCategory"] == null
            ? null
            : LeastSpentCategory.fromJson(json["leastSpentCategory"]),
        categoriesWithNoExpenses: json["categoriesWithNoExpenses"] == null
            ? []
            : List<LeastSpentCategory>.from(json["categoriesWithNoExpenses"]!
                .map((x) => LeastSpentCategory.fromJson(x))),
        totalExpensesForPeriod: json["totalExpensesForPeriod"]?.toDouble(),
        categoryExpensesForPeriod: json["categoryExpensesForPeriod"] == null
            ? []
            : List<LeastSpentCategory>.from(json["categoryExpensesForPeriod"]!
                .map((x) => LeastSpentCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "period": period,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "mostSpentCategory": mostSpentCategory?.toJson(),
        "mostFrequentCategory": mostFrequentCategory?.toJson(),
        "leastSpentCategory": leastSpentCategory?.toJson(),
        "categoriesWithNoExpenses": categoriesWithNoExpenses == null
            ? []
            : List<dynamic>.from(categoriesWithNoExpenses!.map((x) => x.toJson())),
        "totalExpensesForPeriod": totalExpensesForPeriod,
        "categoryExpensesForPeriod": categoryExpensesForPeriod == null
            ? []
            : List<dynamic>.from(categoryExpensesForPeriod!.map((x) => x.toJson())),
      };
}

class LeastSpentCategory {
  Category? category;
  dynamic totalExpenses;

  LeastSpentCategory({
    this.category,
    this.totalExpenses,
  });

  factory LeastSpentCategory.fromJson(Map<String, dynamic> json) => LeastSpentCategory(
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        totalExpenses: json["totalExpenses"],
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "totalExpenses": totalExpenses,
      };
}

class Category {
  int? categoryId;
  String? name;
  String? icon;
  Color? color;
  int? userId;

  Category({
    this.categoryId,
    this.name,
    this.icon,
    this.color,
    this.userId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        name: json["name"],
        icon: json["icon"],
        color: colorValues.map[json["color"]]!,
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "icon": icon,
        "color": colorValues.reverse[color],
        "userId": userId,
      };
}

enum Color { STRING }

final colorValues = EnumValues({"string": Color.STRING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
