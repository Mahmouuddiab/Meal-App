import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/features/Home/Data/Datasource/HomeDataSource.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;

  MealsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Meal>> getMeals() {
    return remoteDataSource.getMeals();
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
