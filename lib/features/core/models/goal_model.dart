// To parse this JSON data, do
//
//     final goalModel = goalModelFromJson(jsonString);

import 'dart:convert';

List<GoalModel> goalModelFromJson(String str) =>
    List<GoalModel>.from(json.decode(str).map((x) => GoalModel.fromJson(x)));

String goalModelToJson(List<GoalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoalModel {
  int? id;
  int? userId;
  String? name;
  String? icon;
  DateTime? deadline;
  double? goalAmount;
  double? actualAmount;

  GoalModel({
    this.id,
    this.userId,
    this.name,
    this.icon,
    this.deadline,
    this.goalAmount,
    this.actualAmount,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        icon: json["icon"],
        deadline: json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
        goalAmount: json["goalAmount"]?.toDouble(),
        actualAmount: json["actualAmount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "icon": icon,
        "deadline": deadline?.toIso8601String(),
        "goalAmount": goalAmount,
        "actualAmount": actualAmount,
      };
}
