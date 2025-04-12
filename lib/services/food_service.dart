import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food_analysis.dart';
import '../repositories/food_log_repository.dart';

class FoodService {
  static const String baseUrl = 'http://192.168.1.3:8000';
  static const String apiKey = 'your-api-key';

  final FoodLogRepository _foodLogRepository = FoodLogRepository();

  Future<FoodAnalysis> analyzeFoodText(String description) async {
    debugPrint("Called $description");
    final response = await http.post(
      Uri.parse('$baseUrl/api/analyze'),
      headers: {
        'Content-Type': 'application/json',
        // 'X-API-Key': apiKey,
      },
      body: jsonEncode({
        'description': description,
      }),
    );

    debugPrint("response ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final analysis = FoodAnalysis.fromJson(jsonResponse['entry']);

      // Save to Firestore if user is logged in
      try {
        await _foodLogRepository.saveFoodLog(analysis);
      } catch (e) {
        debugPrint('Error saving to Firestore: $e');
        // Continue even if Firestore save fails
      }

      return analysis;
    } else {
      debugPrint(response.body);
      throw Exception('Failed to analyze food here');
    }
  }

  Future<FoodAnalysis> analyzeFoodImage(File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/api/track/image'),
    );

    request.headers['X-API-Key'] = apiKey;
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(responseBody);
      final analysis = FoodAnalysis.fromJson(jsonResponse);

      // Save to Firestore if user is logged in
      try {
        await _foodLogRepository.saveFoodLog(analysis);
      } catch (e) {
        debugPrint('Error saving to Firestore: $e');
        // Continue even if Firestore save fails
      }

      return analysis;
    } else {
      throw Exception('Failed to analyze food image');
    }
  }

  Future<List<FoodAnalysis>> getFoodLogs({int skip = 0, int limit = 10}) async {
    try {
      // Try to get logs from Firestore first
      try {
        final today = DateTime.now();
        return await _foodLogRepository.getTodayLogs();
      } catch (firestoreError) {
        // Fallback to API if Firestore fails
        debugPrint('Firestore error, falling back to API: $firestoreError');
        final response = await http.get(
          Uri.parse('$baseUrl/api/logs?skip=$skip&limit=$limit'),
          headers: {
            'X-API-Key': apiKey,
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          return jsonResponse
              .map((json) => FoodAnalysis.fromJson(json))
              .toList();
        } else {
          throw Exception('Failed to fetch food logs');
        }
      }
    } catch (e) {
      debugPrint('Error fetching food logs: $e');
      throw Exception('Failed to fetch food logs: $e');
    }
  }

  // Get food logs for a specific day from Firestore
  Future<List<FoodAnalysis>> getFoodLogsByDay(DateTime date) async {
    return await _foodLogRepository.getLogsByDay(date);
  }

  // Get food logs for a specific week from Firestore
  Future<List<FoodAnalysis>> getFoodLogsByWeek(DateTime date) async {
    return await _foodLogRepository.getLogsByWeek(date);
  }

  // Get food logs for a specific month from Firestore
  Future<List<FoodAnalysis>> getFoodLogsByMonth(DateTime date) async {
    return await _foodLogRepository.getLogsByMonth(date);
  }
}
