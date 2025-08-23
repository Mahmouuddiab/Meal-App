import 'package:bloc/bloc.dart';
import 'package:meal_app/core/Models/meal_model.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase = Supabase.instance.client;
  final MealsRepository repo;

  HomeCubit(this.repo) : super(HomeInitial());

  /// Fetch meals from Supabase
  Future<void> fetchItems(String userId) async {
    emit(HomeLoading());
    try {
      final meals = await repo.getMeals(userId);
      emit(HomeLoaded(meals));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
