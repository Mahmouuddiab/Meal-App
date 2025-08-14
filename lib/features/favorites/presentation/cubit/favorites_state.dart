import 'package:equatable/equatable.dart';
import 'package:meal_app/core/Models/Meal_Model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Meal> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoritesUpdating extends FavoritesState {
  final List<Meal> favorites;
  const FavoritesUpdating(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
class FavoritesCacheUpdated extends FavoritesState {
  final List<String> favoriteIds;
  const FavoritesCacheUpdated(this.favoriteIds);
  
  @override
  List<Object?> get props => [favoriteIds];
}
