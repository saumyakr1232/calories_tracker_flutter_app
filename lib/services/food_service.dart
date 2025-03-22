import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food_analysis.dart';

class FoodService {
  static const String baseUrl = 'http://192.168.1.2:8000';
  static const String apiKey = 'your-api-key';

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
      return FoodAnalysis.fromJson(jsonResponse['entry']);
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
      return FoodAnalysis.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to analyze food image');
    }
  }

  Future<List<FoodAnalysis>> getFoodLogs({int skip = 0, int limit = 10}) async {
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
}