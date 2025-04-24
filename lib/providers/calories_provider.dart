import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/calories_entry_model.dart';
import '../models/food_analysis.dart';
import '../repositories/food_log_repository.dart';
import 'selected_date_provider.dart';

part 'calories_provider.g.dart';

// Provider for the food log repository
@riverpod
FoodLogRepository foodLogRepository(Ref ref) {
  debugPrint('foodLogRepository: Creating new FoodLogRepository instance');
  return FoodLogRepository();
}

// Provider that fetches food logs for the selected date
@riverpod
Future<List<FoodAnalysis>> selectedDateFoodLogs(Ref ref) async {
  final repository = ref.watch(foodLogRepositoryProvider);
  final selectedDate = ref.watch(selectedDateNotifierProvider);

  debugPrint(
      'selectedDateFoodLogs: Fetching food logs for date ${selectedDate.toString()}');
  try {
    final logs = await repository.getLogsByDay(selectedDate);
    debugPrint('selectedDateFoodLogs: Retrieved ${logs.length} food logs');
    return logs;
  } catch (e) {
    debugPrint('selectedDateFoodLogs: Error fetching food logs: $e');
    rethrow;
  }
}

@riverpod
class CaloriesEntryNotifier extends _$CaloriesEntryNotifier {
  @override
  Future<CaloriesEntryModel> build() async {
    debugPrint('CaloriesEntryNotifier: build method called');
    // Watch and wait for the selected date food logs
    final foodLogs = await ref.watch(selectedDateFoodLogsProvider.future);
    debugPrint(
        'CaloriesEntryNotifier: Initial food logs loaded: ${foodLogs.length}');

    // Initialize with empty data or calculated data
    final model = _calculateInitialModel(foodLogs);
    debugPrint('CaloriesEntryNotifier: Initialized with model: $model');

    return model;
  }

  // Calculate the initial state from a list of food logs
  CaloriesEntryModel _calculateInitialModel(List<FoodAnalysis> foodLogs) {
    debugPrint(
        'CaloriesEntryNotifier: _calculateInitialModel called with ${foodLogs.length} logs');
    int totalCalories = 0;
    int totalCarbs = 0;
    int totalProtein = 0;
    int totalFat = 0;

    try {
      for (final log in foodLogs) {
        totalCalories += log.calories.toInt();
        totalCarbs += log.macronutrients.carbohydrates.toInt();
        totalProtein += log.macronutrients.protein.toInt();
        totalFat += log.macronutrients.fat.toInt();
        debugPrint(
            'CaloriesEntryNotifier: Processing log - ${log.description}, calories: ${log.calories}, carbs: ${log.macronutrients.carbohydrates}, protein: ${log.macronutrients.protein}, fat: ${log.macronutrients.fat}');
      }

      final initialMacros = MacrosModel.empty().copyWith(
        consumedCarbs: totalCarbs,
        consumedProtein: totalProtein,
        consumedFat: totalFat,
      );
      debugPrint(
          'CaloriesEntryNotifier: Calculated initial totals - calories: $totalCalories, carbs: $totalCarbs, protein: $totalProtein, fat: $totalFat');

      return CaloriesEntryModel.empty().copyWith(
        foodCalories: totalCalories,
        macros: initialMacros,
      );
    } catch (e) {
      debugPrint('CaloriesEntryNotifier: Error calculating initial model: $e');
      // Return empty model in case of error during initial calculation
      return CaloriesEntryModel.empty();
    }
  }

  void updateFoodCalories(int calories) {
    debugPrint(
        'CaloriesEntryNotifier: updateFoodCalories called with $calories');
    state = AsyncData(state.value!.copyWith(foodCalories: calories));
    debugPrint(
        'CaloriesEntryNotifier: Updated food calories to ${state.value!.foodCalories}');
  }

  void updateExerciseCalories(int calories) {
    debugPrint(
        'CaloriesEntryNotifier: updateExerciseCalories called with $calories');
    state = AsyncData(state.value!.copyWith(exerciseCalories: calories));
    debugPrint(
        'CaloriesEntryNotifier: Updated exercise calories to ${state.value!.exerciseCalories}');
  }

  void updateTargetCalories(int calories) {
    debugPrint(
        'CaloriesEntryNotifier: updateTargetCalories called with $calories');
    state = AsyncData(state.value!.copyWith(targetCalories: calories));
    debugPrint(
        'CaloriesEntryNotifier: Updated target calories to ${state.value!.targetCalories}');
  }

  void updateMacros(MacrosModel macros) {
    debugPrint('CaloriesEntryNotifier: updateMacros called');
    state = AsyncData(state.value!.copyWith(macros: macros));
    debugPrint(
        'CaloriesEntryNotifier: Updated macros - carbs: ${macros.consumedCarbs}/${macros.targetCarbs}, protein: ${macros.consumedProtein}/${macros.targetProtein}, fat: ${macros.consumedFat}/${macros.targetFat}');
  }

  Future addFoodAnalysis(FoodAnalysis analysis) async {
    debugPrint(
        'CaloriesEntryNotifier: addFoodAnalysis called with ${analysis.description}, calories: ${analysis.calories}');

    // Ensure state has data before proceeding
    if (state.value == null) {
      debugPrint(
          'CaloriesEntryNotifier: State value is null, cannot add food analysis.');
      return;
    }

    final currentState = state.value!;

    // Update food calories
    final newFoodCalories =
        currentState.foodCalories + analysis.calories.toInt();
    debugPrint(
        'CaloriesEntryNotifier: Updating food calories from ${currentState.foodCalories} to $newFoodCalories');

    // Update macros
    final macros = analysis.macronutrients;
    final newMacros = currentState.macros.copyWith(
      consumedCarbs:
          currentState.macros.consumedCarbs + macros.carbohydrates.toInt(),
      consumedProtein:
          currentState.macros.consumedProtein + macros.protein.toInt(),
      consumedFat: currentState.macros.consumedFat + macros.fat.toInt(),
    );
    debugPrint(
        'CaloriesEntryNotifier: Updating macros - carbs: ${currentState.macros.consumedCarbs} to ${newMacros.consumedCarbs}, protein: ${currentState.macros.consumedProtein} to ${newMacros.consumedProtein}, fat: ${currentState.macros.consumedFat} to ${newMacros.consumedFat}');

    state = AsyncData(currentState.copyWith(
      foodCalories: newFoodCalories,
      macros: newMacros,
    ));
    debugPrint(
        'CaloriesEntryNotifier: State updated with new calories and macros');

    // Save the food analysis to the repository
    debugPrint('CaloriesEntryNotifier: Saving food analysis to repository');
    await ref.read(foodLogRepositoryProvider).saveFoodLog(analysis);

    // Invalidate the provider to refetch logs for the current date
    ref.invalidate(selectedDateFoodLogsProvider);
    debugPrint(
        'CaloriesEntryNotifier: Invalidated selectedDateFoodLogsProvider');
  }

  // This method is now replaced by _calculateInitialModel and direct updates
  // void _updateFromFoodLogs(List<FoodAnalysis> foodLogs) { ... }
}

@riverpod
int remainingCalories(Ref ref) {
  final caloriesEntryAsync = ref.watch(caloriesEntryNotifierProvider);

  return caloriesEntryAsync.when(
    data: (caloriesEntry) {
      final remaining = caloriesEntry.targetCalories -
          caloriesEntry.foodCalories +
          caloriesEntry.exerciseCalories;
      debugPrint(
          'remainingCalories: Calculated remaining calories: $remaining (target: ${caloriesEntry.targetCalories}, food: ${caloriesEntry.foodCalories}, exercise: ${caloriesEntry.exerciseCalories})');
      return remaining;
    },
    loading: () => 0, // Or some default/loading state value
    error: (err, stack) {
      debugPrint(
          'remainingCalories: Error calculating remaining calories: $err');
      return 0; // Or handle error appropriately
    },
  );
}
