import 'package:meal_app/features/Home/Data/models/ingredient_model.dart';
import 'package:meal_app/features/Home/Data/models/nutrition_model.dart';
import 'package:meal_app/features/Home/Data/models/step_model.dart';

class Meal {
  final String id;
  final String category;
  final String title;
  final int time;
  final String imageUrl;
  final String summary;
  final int servings;
  final double rating;
  final List<Ingredient> ingredientsList;
  final List<Nutrition> nutritionList;
  final List<Steps> stepsList;

  Meal({
    required this.id,
    required this.category,
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.summary,
    required this.servings,
    required this.rating,
    required this.ingredientsList,
    required this.nutritionList,
    required this.stepsList,
  });

  factory Meal.fromJson(Map<dynamic, dynamic> json) {
    String summary = json['summary'] ?? '';

    List<Nutrition> nutritionList = [];
    final regex = RegExp(r'(\w+):\s*([\d.]+)\s*([a-zA-Zµ]+)?');
    for (final match in regex.allMatches(summary)) {
      nutritionList.add(
        Nutrition(
          name: match.group(1) ?? '',
          value: double.tryParse(match.group(2) ?? '0') ?? 0,
          unit: match.group(3) ?? '',
        ),
      );
    }
    summary = summary.replaceAll(
      RegExp(r'Nutritional information \(per serving\):', caseSensitive: false),
      '',
    );
    summary =
        summary.replaceAll(RegExp(r'\b\w+:\s*[\d.]+\s*[a-zA-Zµ]*'), '').trim();
    summary = summary.replaceAll(RegExp(r'[,\s]+'), ' ').trim();
    return Meal(
      id: json['id'] as String,
      category: json['meal_type'] ?? '',
      title: json['name'] ?? '',
      time: json['cook_time'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      summary: summary,
      servings: json['serving_size'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      ingredientsList:
          (json['ingredients'] as List)
              .map((i) => Ingredient.fromJson(i))
              .toList(),
      nutritionList: nutritionList,
      stepsList:
          (json['meal_steps'] as List? ?? []).map((i) {
            if (i is String) {
              return Steps(description: i);
            } else {
              return Steps.fromJson(i);
            }
          }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'meal_type': category,
    'name': title,
    'cook_time': time,
    'image_url': imageUrl,
    'summary': summary,
    'serving_size': servings,
    'rating': rating,
    'ingredients': ingredientsList.map((i) => i.toJson()).toList(),
    'nutrition': nutritionList.map((i) => i.toJson()).toList(),
    'meal_steps': stepsList.map((i) => i.toJson()).toList(),
  };
}
