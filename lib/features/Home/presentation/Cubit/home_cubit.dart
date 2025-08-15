import 'package:bloc/bloc.dart';
import 'package:meal_app/features/Home/Domain/Repository/Repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase = Supabase.instance.client;

  HomeCubit(this.repo) : super(HomeInitial());
  final MealsRepository repo;

  /// Fetch mealsfrom Supabase
  Future<void> fetchItems() async {
    emit(HomeLoading());
    try {
      final response = await supabase
    .from('meals')
    .select('*')
    .order('created_at', ascending: false);



      // Add local favorite tracking
      final meals =
          (response as List).map((item) {
            return {...item, 'isFavorite': item['is_favorite'] ?? false};
          }).toList();

      emit(HomeLoaded(meals));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Toggle favorite status
  void toggleFavorite(String id) {
    if (state is HomeLoaded) {
      final currentmeals = List<dynamic>.from(
        (state as HomeLoaded).items,
      );

      final updatedmeals =
          currentmeals.map((item) {
            if (item['id'] == id) {
              return {...item, 'isFavorite': !(item['isFavorite'] as bool)};
            }
            return item;
          }).toList();

      emit(HomeLoaded(updatedmeals));
    }
  }

  /// Get favorites only
  List get favorites {
    if (state is HomeLoaded) {
      return (state as HomeLoaded).items
          .where((item) => item['isFavorite'] == true)
          .toList();
    }
    return [];
  }
}
