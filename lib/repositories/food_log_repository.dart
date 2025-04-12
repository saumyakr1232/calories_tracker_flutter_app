import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_analysis.dart';
import '../services/firestore_service.dart';

/// Repository class for handling food log operations
/// This class provides methods for storing and retrieving food logs
/// with support for querying by day, week, and month
class FoodLogRepository {
  final FirestoreService _firestoreService;

  FoodLogRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  /// Save a food log entry to Firestore
  Future<void> saveFoodLog(FoodAnalysis foodAnalysis) async {
    await _firestoreService.saveFoodLog(foodAnalysis);
  }

  /// Get food logs for the current day
  Future<List<FoodAnalysis>> getTodayLogs() async {
    return await _firestoreService.getFoodLogsByDay(DateTime.now());
  }

  /// Get food logs for a specific day
  Future<List<FoodAnalysis>> getLogsByDay(DateTime date) async {
    return await _firestoreService.getFoodLogsByDay(date);
  }

  /// Get food logs for the current week
  Future<List<FoodAnalysis>> getCurrentWeekLogs() async {
    return await _firestoreService.getFoodLogsByWeek(DateTime.now());
  }

  /// Get food logs for a specific week
  Future<List<FoodAnalysis>> getLogsByWeek(DateTime date) async {
    return await _firestoreService.getFoodLogsByWeek(date);
  }

  /// Get food logs for the current month
  Future<List<FoodAnalysis>> getCurrentMonthLogs() async {
    return await _firestoreService.getFoodLogsByMonth(DateTime.now());
  }

  /// Get food logs for a specific month
  Future<List<FoodAnalysis>> getLogsByMonth(DateTime date) async {
    return await _firestoreService.getFoodLogsByMonth(date);
  }

  /// Calculate total calories for a list of food logs
  double calculateTotalCalories(List<FoodAnalysis> logs) {
    return logs.fold(0, (sum, log) => sum + log.calories);
  }

  /// Calculate average calories per day for a list of food logs
  double calculateAverageCaloriesPerDay(List<FoodAnalysis> logs, int days) {
    if (days <= 0) return 0;
    return calculateTotalCalories(logs) / days;
  }

  /// Calculate macronutrient totals for a list of food logs
  Map<String, double> calculateMacroTotals(List<FoodAnalysis> logs) {
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;

    for (var log in logs) {
      totalProtein += log.macronutrients.protein;
      totalCarbs += log.macronutrients.carbohydrates;
      totalFat += log.macronutrients.fat;
      totalFiber += log.macronutrients.fiber;
    }

    return {
      'protein': totalProtein,
      'carbohydrates': totalCarbs,
      'fat': totalFat,
      'fiber': totalFiber,
    };
  }
}
