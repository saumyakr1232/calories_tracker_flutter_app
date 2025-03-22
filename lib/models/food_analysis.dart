import 'package:json_annotation/json_annotation.dart';

part 'food_analysis.g.dart';

@JsonSerializable()
class FoodAnalysis {
  final String description;
  final double calories;
  final Macronutrients macronutrients;
  final Micronutrients micronutrients;
  final DateTime? timestamp;

  FoodAnalysis({
    required this.description,
    required this.calories,
    required this.macronutrients,
    required this.micronutrients,
    this.timestamp,
  });

  factory FoodAnalysis.fromJson(Map<String, dynamic> json) =>
      _$FoodAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$FoodAnalysisToJson(this);
}

@JsonSerializable()
class Macronutrients {
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;

  Macronutrients({
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
  });

  factory Macronutrients.fromJson(Map<String, dynamic> json) =>
      _$MacronutrientsFromJson(json);

  Map<String, dynamic> toJson() => _$MacronutrientsToJson(this);
}

@JsonSerializable()
class Micronutrients {
  final Map<String, String> vitamins;
  final Map<String, String> minerals;

  Micronutrients({
    required this.vitamins,
    required this.minerals,
  });

  factory Micronutrients.fromJson(Map<String, dynamic> json) =>
      _$MicronutrientsFromJson(json);

  Map<String, dynamic> toJson() => _$MicronutrientsToJson(this);
}