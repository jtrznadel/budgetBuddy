// To parse this JSON data, do
//
//     final statsModel = statsModelFromJson(jsonString);

import 'dart:convert';

StatsModel statsModelFromJson(String str) => StatsModel.fromJson(json.decode(str));

String statsModelToJson(StatsModel data) => json.encode(data.toJson());

class StatsModel {
  List<Yearly>? yearly;
  List<Monthly>? monthly;
  List<Daily>? daily;
  double? last31DaysTotalExpenses;
  List<Daily>? dailyLast31Days;
  double? currentMonth;
  List<Daily>? dailyCurrentMonth;

  StatsModel({
    this.yearly,
    this.monthly,
    this.daily,
    this.last31DaysTotalExpenses,
    this.dailyLast31Days,
    this.currentMonth,
    this.dailyCurrentMonth,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
        yearly: json["yearly"] == null
            ? []
            : List<Yearly>.from(json["yearly"]!.map((x) => Yearly.fromJson(x))),
        monthly: json["monthly"] == null
            ? []
            : List<Monthly>.from(json["monthly"]!.map((x) => Monthly.fromJson(x))),
        daily: json["daily"] == null
            ? []
            : List<Daily>.from(json["daily"]!.map((x) => Daily.fromJson(x))),
        last31DaysTotalExpenses: json["last31DaysTotalExpenses"]?.toDouble(),
        dailyLast31Days: json["dailyLast31Days"] == null
            ? []
            : List<Daily>.from(json["dailyLast31Days"]!.map((x) => Daily.fromJson(x))),
        currentMonth: json["currentMonth"]?.toDouble(),
        dailyCurrentMonth: json["dailyCurrentMonth"] == null
            ? []
            : List<Daily>.from(json["dailyCurrentMonth"]!.map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "yearly":
            yearly == null ? [] : List<dynamic>.from(yearly!.map((x) => x.toJson())),
        "monthly":
            monthly == null ? [] : List<dynamic>.from(monthly!.map((x) => x.toJson())),
        "daily": daily == null ? [] : List<dynamic>.from(daily!.map((x) => x.toJson())),
        "last31DaysTotalExpenses": last31DaysTotalExpenses,
        "dailyLast31Days": dailyLast31Days == null
            ? []
            : List<dynamic>.from(dailyLast31Days!.map((x) => x.toJson())),
        "currentMonth": currentMonth,
        "dailyCurrentMonth": dailyCurrentMonth == null
            ? []
            : List<dynamic>.from(dailyCurrentMonth!.map((x) => x.toJson())),
      };
}

class Daily {
  DateTime? date;
  String? dayOfWeek;
  double? totalExpenses;
  List<Expense>? expenses;

  Daily({
    this.date,
    this.dayOfWeek,
    this.totalExpenses,
    this.expenses,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dayOfWeek: json["dayOfWeek"],
        totalExpenses: json["totalExpenses"]?.toDouble(),
        expenses: json["expenses"] == null
            ? []
            : List<Expense>.from(json["expenses"]!.map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "dayOfWeek": dayOfWeek,
        "totalExpenses": totalExpenses,
        "expenses":
            expenses == null ? [] : List<dynamic>.from(expenses!.map((x) => x.toJson())),
      };
}

class Expense {
  int? expenseId;
  String? name;
  String? description;
  double? price;
  DateTime? date;
  int? userId;
  int? categoryId;
  dynamic category;

  Expense({
    this.expenseId,
    this.name,
    this.description,
    this.price,
    this.date,
    this.userId,
    this.categoryId,
    this.category,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        expenseId: json["expenseId"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
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

class Monthly {
  int? year;
  String? month;
  double? totalExpenses;
  List<Week>? weeks;

  Monthly({
    this.year,
    this.month,
    this.totalExpenses,
    this.weeks,
  });

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        year: json["year"],
        month: json["month"],
        totalExpenses: json["totalExpenses"]?.toDouble(),
        weeks: json["weeks"] == null
            ? []
            : List<Week>.from(json["weeks"]!.map((x) => Week.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "totalExpenses": totalExpenses,
        "weeks": weeks == null ? [] : List<dynamic>.from(weeks!.map((x) => x.toJson())),
      };
}

class Week {
  int? week;
  double? totalExpenses;
  List<Expense>? expenses;

  Week({
    this.week,
    this.totalExpenses,
    this.expenses,
  });

  factory Week.fromJson(Map<String, dynamic> json) => Week(
        week: json["week"],
        totalExpenses: json["totalExpenses"]?.toDouble(),
        expenses: json["expenses"] == null
            ? []
            : List<Expense>.from(json["expenses"]!.map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "week": week,
        "totalExpenses": totalExpenses,
        "expenses":
            expenses == null ? [] : List<dynamic>.from(expenses!.map((x) => x.toJson())),
      };
}

class Yearly {
  int? year;
  double? totalExpenses;
  List<Expense>? expenses;

  Yearly({
    this.year,
    this.totalExpenses,
    this.expenses,
  });

  factory Yearly.fromJson(Map<String, dynamic> json) => Yearly(
        year: json["year"],
        totalExpenses: json["totalExpenses"]?.toDouble(),
        expenses: json["expenses"] == null
            ? []
            : List<Expense>.from(json["expenses"]!.map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "totalExpenses": totalExpenses,
        "expenses":
            expenses == null ? [] : List<dynamic>.from(expenses!.map((x) => x.toJson())),
      };
}
