// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calories_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaloriesEntryModel _$CaloriesEntryModelFromJson(Map<String, dynamic> json) =>
    _CaloriesEntryModel(
      foodCalories: (json['foodCalories'] as num).toInt(),
      exerciseCalories: (json['exerciseCalories'] as num).toInt(),
      targetCalories: (json['targetCalories'] as num).toInt(),
      macros: MacrosModel.fromJson(json['macros'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CaloriesEntryModelToJson(_CaloriesEntryModel instance) =>
    <String, dynamic>{
      'foodCalories': instance.foodCalories,
      'exerciseCalories': instance.exerciseCalories,
      'targetCalories': instance.targetCalories,
      'macros': instance.macros,
    };

_MacrosModel _$MacrosModelFromJson(Map<String, dynamic> json) => _MacrosModel(
      consumedCarbs: (json['consumedCarbs'] as num).toInt(),
      targetCarbs: (json['targetCarbs'] as num).toInt(),
      consumedProtein: (json['consumedProtein'] as num).toInt(),
      targetProtein: (json['targetProtein'] as num).toInt(),
      consumedFat: (json['consumedFat'] as num).toInt(),
      targetFat: (json['targetFat'] as num).toInt(),
    );

Map<String, dynamic> _$MacrosModelToJson(_MacrosModel instance) =>
    <String, dynamic>{
      'consumedCarbs': instance.consumedCarbs,
      'targetCarbs': instance.targetCarbs,
      'consumedProtein': instance.consumedProtein,
      'targetProtein': instance.targetProtein,
      'consumedFat': instance.consumedFat,
      'targetFat': instance.targetFat,
    };
