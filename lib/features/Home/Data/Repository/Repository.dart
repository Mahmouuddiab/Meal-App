import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/features/Home/Data/Datasource/HomeDataSource.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;

  MealsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Meal>> getMeals(String userId) {
    return remoteDataSource.getMeals(userId);
  }

  @override
  Future<void> deleteMeal(String mealId, String userId) {
    return remoteDataSource.deleteMeal(userId, mealId);
  }

 @override
  Future<bool> isFavorite(String userId, String mealId) {
    return remoteDataSource.isFavorite(userId, mealId);
  }

  @override
  Future<void> toggleFavorite(String userId, Meal meal) {
    return remoteDataSource.toggleFavorite(userId, meal);
  }
}
