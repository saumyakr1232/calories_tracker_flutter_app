import 'package:freezed_annotation/freezed_annotation.dart';

part 'calories_entry_model.freezed.dart';
part 'calories_entry_model.g.dart';

@freezed
class CaloriesEntryModel with _$CaloriesEntryModel {
  const factory CaloriesEntryModel({
    required int foodCalories,
    required int exerciseCalories,
    required int targetCalories,
    required MacrosModel macros,
  }) = _CaloriesEntryModel;

  factory CaloriesEntryModel.fromJson(Map<String, dynamic> json) =>
      _$CaloriesEntryModelFromJson(json);

  factory CaloriesEntryModel.empty() => CaloriesEntryModel(
        foodCalories: 0,
        exerciseCalories: 0,
        targetCalories: 2000,
        macros: MacrosModel.empty(),
      );
}

@freezed
class MacrosModel with _$MacrosModel {
  const factory MacrosModel({
    required int consumedCarbs,
    required int targetCarbs,
    required int consumedProtein,
    required int targetProtein,
    required int consumedFat,
    required int targetFat,
  }) = _MacrosModel;

  factory MacrosModel.fromJson(Map<String, dynamic> json) =>
      _$MacrosModelFromJson(json);

  factory MacrosModel.empty() => const MacrosModel(
        consumedCarbs: 0,
        targetCarbs: 250,
        consumedProtein: 40,
        targetProtein: 125,
        consumedFat: 24,
        targetFat: 56,
      );
}
