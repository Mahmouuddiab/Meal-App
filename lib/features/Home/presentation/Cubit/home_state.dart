part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Meal> meals; // Changed from dynamic items to List<Meal>

  HomeLoaded(this.meals);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
