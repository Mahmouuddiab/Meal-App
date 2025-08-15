import 'package:meal_app/features/favorites/domain/repositories/favorite_repository.dart';

class IsFavorite {
  final FavoritesRepository repository;
  IsFavorite(this.repository);

  Future<bool> call(String userId, String mealId) async {
    return await repository.isFavorite(userId, mealId);
  }
}