import 'package:meal_app/features/Home/Data/models/ingredient_model.dart';
import 'package:meal_app/features/Home/Data/models/nutrition_model.dart';
import 'package:meal_app/features/Home/Data/models/step_model.dart';

class Meal {
  final String id;
  final String category;
  final String title;
  final String time;
  final String imageUrl;
  final String summary;
  final int servings;
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
    required this.ingredientsList,
    required this.nutritionList,
    required this.stepsList,
  });

  factory Meal.fromJson(Map<dynamic, dynamic> json) {
    return Meal(
      id: json['id'] as String,
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      imageUrl: json['image_url'] ?? '',
      summary: json['summary'] ?? '',
      servings: json['serving'] ?? 0,
      ingredientsList:
          (json['ingredient_items'] as List)
              .map((i) => Ingredient.fromJson(i))
              .toList(),
      nutritionList:
          (json['nutrition'] as List)
              .map((i) => Nutrition.fromJson(i))
              .toList(),
      stepsList: (json['steps'] as List).map((i) => Steps.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'title': title,
    'time': time,
    'image_url': imageUrl,
    'summary': summary,
    'serving': servings,
    'ingredient_items': ingredientsList.map((i) => i.toJson()).toList(),
    'nutrition': nutritionList.map((i) => i.toJson()).toList(),
    'steps': stepsList.map((i) => i.toJson()).toList(),
  };
}
