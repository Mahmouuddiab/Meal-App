import 'package:meal_app/core/Models/meal_model.dart';

abstract class FavoritesRepository {
  Future<List<Meal>> getFavorites(String userId);
  Future<bool> isFavorite(String userId, String mealId);
  Future<void> toggleFavorite(String userId, Meal meal);
  Future<void> addFavorite(String userId, String mealId);
}