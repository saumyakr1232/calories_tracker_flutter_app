import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/calories_entry_model.dart';
import '../models/food_analysis.dart';

part 'calories_provider.g.dart';

@riverpod
class CaloriesEntryNotifier extends _$CaloriesEntryNotifier {
  @override
  CaloriesEntryModel build() {
    return CaloriesEntryModel.empty();
  }

  void updateFoodCalories(int calories) {
    state = state.copyWith(foodCalories: calories);
  }

  void updateExerciseCalories(int calories) {
    state = state.copyWith(exerciseCalories: calories);
  }

  void updateTargetCalories(int calories) {
    state = state.copyWith(targetCalories: calories);
  }

  void updateMacros(MacrosModel macros) {
    state = state.copyWith(macros: macros);
  }

  void addFoodAnalysis(FoodAnalysis analysis) {
    // Update food calories
    final newFoodCalories = state.foodCalories + analysis.calories.toInt();

    // Update macros
    final macros = analysis.macronutrients;
    final newMacros = state.macros.copyWith(
      consumedCarbs: state.macros.consumedCarbs + macros.carbohydrates.toInt(),
      consumedProtein: state.macros.consumedProtein + macros.protein.toInt(),
      consumedFat: state.macros.consumedFat + macros.fat.toInt(),
    );

    state = state.copyWith(
      foodCalories: newFoodCalories,
      macros: newMacros,
    );
  }
}

@riverpod
int remainingCalories(Ref ref) {
  final caloriesEntry = ref.watch(caloriesEntryNotifierProvider);
  return caloriesEntry.targetCalories -
      caloriesEntry.foodCalories +
      caloriesEntry.exerciseCalories;
}
