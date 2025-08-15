import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/features/favorites/domain/repositories/favorite_repository.dart';

class ToggleFavorite {
  final FavoritesRepository repository;
  ToggleFavorite(this.repository);

  Future<void> call(String userId, Meal meal) async {
    await repository.toggleFavorite(userId, meal);
  }
}
