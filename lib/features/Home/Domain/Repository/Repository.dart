
import 'package:meal_app/core/Models/meal_model.dart';

abstract class MealsRepository {
  Future<List<Meal>>getMeals(String userId);
   Future<void> deleteMeal(String mealId,String userId);
  Future<bool> isFavorite(String userId, String mealId);
  Future<void> toggleFavorite(String userId, Meal meal);
  
  }
