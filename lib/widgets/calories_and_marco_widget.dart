import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calories_provider.dart';

class CaloriesAndMacrosWidget extends ConsumerWidget {
  const CaloriesAndMacrosWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caloriesEntry = ref.watch(caloriesEntryNotifierProvider);
    final remainingCals = ref.watch(remainingCaloriesProvider);
    final sw = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: (sw - 24) / 2,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orangeAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Calories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${caloriesEntry.foodCalories}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Food",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${caloriesEntry.exerciseCalories}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Exercise",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$remainingCals",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Remaining",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          width: (sw - 24) / 2,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pinkAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.pie_chart,
                    color: Colors.pinkAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Calories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${caloriesEntry.macros.consumedCarbs}/${caloriesEntry.macros.targetCarbs}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Carbs (g)",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${caloriesEntry.macros.consumedProtein}/${caloriesEntry.macros.targetProtein}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Protein (g)",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${caloriesEntry.macros.consumedFat}/${caloriesEntry.macros.targetFat}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Fat (g)",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
