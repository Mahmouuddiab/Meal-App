
import 'package:meal_app/core/Models/Meal_Model.dart';

abstract class MealsRepository {
  Future<List<Meal>>getMeals();
  Future<bool> isFavorite(String userId, String mealId);
  Future<void> toggleFavorite(String userId, Meal meal);
  
  }
