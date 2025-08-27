import 'package:meal_app/core/Models/meal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealsRemoteDataSource {
  final SupabaseClient supabase;
  MealsRemoteDataSource(this.supabase);

  // Get all meals
  Future<List<Meal>> getMeals(String userId) async {
    final res = await supabase
        .from('meals')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return res.map((e) => Meal.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> deleteMeal(String userId, String mealId) async {
    try {
      final response =
          await Supabase.instance.client
              .from('meals')
              .delete()
              .eq('id', mealId)
              .select();

      print("Meal deleted successfully: $response");
    } catch (e) {
      print("Error deleting meal: $e");
    }
  }

  // Check if a meal is a favorite for a specific user
  Future<bool> isFavorite(String userId, String mealId) async {
    final res =
        await supabase
            .from('favorites')
            .select('id')
            .eq('user_id', userId)
            .eq('meal_id', mealId)
            .maybeSingle();
    return res != null;
  }

  /// Toggle favorite for a meal
  Future<void> toggleFavorite(String userId, Meal meal) async {
    final existing =
        await supabase
            .from('favorites')
            .select('id')
            .eq('user_id', userId)
            .eq('meal_id', meal.id)
            .maybeSingle();

    if (existing == null) {
      // Add to favorites
      await supabase.from('favorites').insert({
        'user_id': userId,
        'meal_id': meal.id,
      });
    } else {
      // Remove from favorites
      await supabase.from('favorites').delete().eq('id', existing['id']);
    }
  }
}
