// To parse this JSON data, do
//
//     final forecastModel = forecastModelFromJson(jsonString);

import 'dart:convert';

ForecastModel forecastModelFromJson(String str) =>
    ForecastModel.fromJson(json.decode(str));

String forecastModelToJson(ForecastModel data) => json.encode(data.toJson());

class ForecastModel {
  double? average;
  double? lowerBound;
  double? upperBound;

  ForecastModel({
    this.average,
    this.lowerBound,
    this.upperBound,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        average: json["average"]?.toDouble(),
        lowerBound: json["lowerBound"]?.toDouble(),
        upperBound: json["upperBound"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "lowerBound": lowerBound,
        "upperBound": upperBound,
      };
}
