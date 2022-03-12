// * https://app.quicktype.io/

// 🎯 Dart imports:
import "dart:convert";

// 🌎 Project imports:
import "package:food_busters/models/label10n.dart";

class MLAPIResult {
  MLAPIResult({
    required this.foodName,
    required this.foodNutrition,
    required this.confidence,
    required this.version,
  });

  final Label10n foodName;
  final FoodNutrition foodNutrition;
  final double confidence;
  final String version;

  factory MLAPIResult.fromRawJson(String str) =>
      MLAPIResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MLAPIResult.fromJson(Map<String, dynamic> json) => MLAPIResult(
        foodName: Label10n.fromJson(json["foodName"]),
        foodNutrition: FoodNutrition.fromJson(json["foodNutrition"]),
        confidence: json["confidence"].toDouble(),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "foodName": foodName.toJson(),
        "foodNutrition": foodNutrition.toJson(),
        "confidence": confidence,
        "version": version,
      };
}

class FoodNutrition {
  FoodNutrition({
    required this.carbohydrate,
    required this.fat,
    required this.protein,
    required this.pollution,
  });

  final double carbohydrate;
  final double fat;
  final double protein;
  final double pollution;

  factory FoodNutrition.fromRawJson(String str) =>
      FoodNutrition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static double td(dynamic val) {
    if (val is int) return val.toDouble();
    if (val is double) return val;
    return 0;
  }

  factory FoodNutrition.fromJson(Map<String, dynamic> json) => FoodNutrition(
      carbohydrate: td(json["carbohydrate"]),
      fat: td(json["fat"]),
      protein: td(json["protein"]),
      pollution: td(json["pollution"]));

  Map<String, double> toJson() => {
        "carbohydrate": carbohydrate,
        "fat": fat,
        "protein": protein,
      };
}
