import 'package:bloc/bloc.dart';
import 'package:meal_app/core/Models/Meal_Model.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase = Supabase.instance.client;
  final MealsRepository repo;

  HomeCubit(this.repo) : super(HomeInitial());

  /// Fetch meals from Supabase
  Future<void> fetchItems() async {
    emit(HomeLoading());
    try {
      final meals = await repo.getMeals();
      emit(HomeLoaded(meals));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
