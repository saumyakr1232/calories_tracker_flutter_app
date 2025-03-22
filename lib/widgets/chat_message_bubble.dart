import 'dart:io';
import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../models/food_analysis.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTimestamp(message.timestamp),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (!message.isUser)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 16),
                        onPressed: () {
                          // TODO: Implement edit functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 16),
                        onPressed: () {
                          // TODO: Implement delete functionality
                        },
                      ),
                    ],
                  ),
              ],
            ),
            if (message.hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  File(message.imagePath!),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            if (message.type == MessageType.text || message.type == MessageType.image)
              Text(
                message.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (message.hasAnalysis) _buildAnalysisCard(context, message.analysis!),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisCard(BuildContext context, FoodAnalysis analysis) {
    return Card(
      margin: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              analysis.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Calories: ${analysis.calories.toStringAsFixed(1)} kcal',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8.0),
            _buildMacronutrients(context, analysis.macronutrients),
            const SizedBox(height: 8.0),
            _buildMicronutrients(context, analysis.micronutrients),
          ],
        ),
      ),
    );
  }

  Widget _buildMacronutrients(BuildContext context, Macronutrients macros) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Macronutrients',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMacroItem(context, 'Protein', macros.protein),
            _buildMacroItem(context, 'Carbs', macros.carbohydrates),
            _buildMacroItem(context, 'Fat', macros.fat),
            _buildMacroItem(context, 'Fiber', macros.fiber),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroItem(BuildContext context, String label, double value) {
    return Column(
      children: [
        Text(
          '${value.toStringAsFixed(1)}g',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildMicronutrients(BuildContext context, Micronutrients micros) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Micronutrients',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4.0),
        if (micros.vitamins.isNotEmpty)
          _buildMicroList(context, 'Vitamins', micros.vitamins),
        if (micros.minerals.isNotEmpty)
          _buildMicroList(context, 'Minerals', micros.minerals),
      ],
    );
  }

  Widget _buildMicroList(BuildContext context, String title, Map<String, String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Wrap(
          spacing: 8.0,
          children: items.entries.map((entry) {
            return Chip(
              label: Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}