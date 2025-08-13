import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/features/favorites/domain/repositories/favorite_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;
  GetFavorites(this.repository);

  Future<List<Meal>> call(String userId) {
    return repository.getFavorites(userId);
  }
}
