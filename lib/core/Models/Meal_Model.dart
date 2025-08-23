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
    return Meal(
      id: json['id'] as String,
      category: json['meal_type'] ?? '',
      title: json['name'] ?? '',
      time: json['cook_time'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      summary: json['summary'] ?? '',
      servings: json['serving_size'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      ingredientsList:
          (json['ingredients'] as List)
              .map((i) => Ingredient.fromJson(i))
              .toList(),
      nutritionList:
          (json['nutrition'] as List? ?? [])
              .map((i) => Nutrition.fromJson(i))
              .toList(),
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
