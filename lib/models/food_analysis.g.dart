// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodAnalysis _$FoodAnalysisFromJson(Map<String, dynamic> json) => FoodAnalysis(
      description: json['description'] as String,
      calories: (json['calories'] as num).toDouble(),
      macronutrients: Macronutrients.fromJson(
          json['macronutrients'] as Map<String, dynamic>),
      micronutrients: Micronutrients.fromJson(
          json['micronutrients'] as Map<String, dynamic>),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$FoodAnalysisToJson(FoodAnalysis instance) =>
    <String, dynamic>{
      'description': instance.description,
      'calories': instance.calories,
      'macronutrients': instance.macronutrients,
      'micronutrients': instance.micronutrients,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

Macronutrients _$MacronutrientsFromJson(Map<String, dynamic> json) =>
    Macronutrients(
      protein: (json['protein'] as num).toDouble(),
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
    );

Map<String, dynamic> _$MacronutrientsToJson(Macronutrients instance) =>
    <String, dynamic>{
      'protein': instance.protein,
      'carbohydrates': instance.carbohydrates,
      'fat': instance.fat,
      'fiber': instance.fiber,
    };

Micronutrients _$MicronutrientsFromJson(Map<String, dynamic> json) =>
    Micronutrients(
      vitamins: Map<String, String>.from(json['vitamins'] as Map),
      minerals: Map<String, String>.from(json['minerals'] as Map),
    );

Map<String, dynamic> _$MicronutrientsToJson(Micronutrients instance) =>
    <String, dynamic>{
      'vitamins': instance.vitamins,
      'minerals': instance.minerals,
    };
