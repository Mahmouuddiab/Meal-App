// ignore_for_file: unnecessary_type_check

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/features/favorites/domain/repositories/favorite_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repo;

  final Map<String, bool> _favoriteCache = {};

  FavoritesCubit(this.repo) : super(FavoritesInitial());

  Future<void> loadFavorites(String userId) async {
    emit(FavoritesLoading());
    try {
      final favs = await repo.getFavorites(userId);

      _favoriteCache.clear();
      for (var meal in favs) {
        _favoriteCache[meal.id] = true;
      }

      emit(FavoritesLoaded(favs));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(String userId, Meal meal) async {
    final currentState = state;
    final isCurrentlyFav = _favoriteCache[meal.id] ?? false;
    final willBeFav = !isCurrentlyFav;

    _favoriteCache[meal.id] = willBeFav;

    if (currentState is FavoritesLoaded) {
      final updatedList = List<Meal>.from(currentState.favorites);

      if (willBeFav) {
        if (!updatedList.any((m) => m.id == meal.id)) {
          updatedList.insert(0, meal);
        }
      } else {
        updatedList.removeWhere((m) => m.id == meal.id);
      }

      emit(FavoritesUpdating(updatedList));

      try {
        await repo.toggleFavorite(userId, meal);
        emit(FavoritesLoaded(updatedList));
      } catch (e) {
        _favoriteCache[meal.id] = isCurrentlyFav;
        emit(FavoritesError(e.toString()));
        if (currentState is FavoritesLoaded) {
          emit(currentState);
        }
      }
    } else {
      try {
        await repo.toggleFavorite(userId, meal);
      } catch (e) {
        _favoriteCache[meal.id] = isCurrentlyFav;
        emit(FavoritesError(e.toString()));
      }
    }
  }

  bool isFavorite(String mealId) {
    return _favoriteCache[mealId] ?? false;
  }

  Future<bool> checkIsFavorite(String userId, String mealId) async {
    if (_favoriteCache.containsKey(mealId)) {
      return _favoriteCache[mealId]!;
    }

    try {
      final result = await repo.isFavorite(userId, mealId);
      _favoriteCache[mealId] = result;
      return result;
    } catch (e) {
      return false;
    }
  }
}
