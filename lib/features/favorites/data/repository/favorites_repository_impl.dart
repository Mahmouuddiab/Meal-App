import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/features/favorites/data/data_sources/favorites_remote_data_source.dart';
import 'package:meal_app/features/favorites/domain/repositories/favorite_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Meal>> getFavorites(String userId) async {
    return await remoteDataSource.getFavorites(userId);
  }

  @override
  Future<bool> isFavorite(String userId, String mealId) async {
    return await remoteDataSource.isFavorite(userId, mealId);
  }

  @override
  Future<void> toggleFavorite(String userId, Meal meal) async {
    return await remoteDataSource.toggleFavorite(userId, meal);
  }

  @override
  Future<void> addFavorite(String userId, String mealId) async {
    return await remoteDataSource.addFavorite(userId, mealId); 
  }
}