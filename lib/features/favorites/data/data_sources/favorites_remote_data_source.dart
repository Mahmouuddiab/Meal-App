import 'package:meal_app/core/Models/meal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesRemoteDataSource {
  final SupabaseClient supabase;
  FavoritesRemoteDataSource(this.supabase);

  Future<List<Meal>> getFavorites(String userId) async {
    final res = await supabase
        .from('favorites')
        .select('meal:meals(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    final List list = res as List<dynamic>;
    return list
        .map((e) => Meal.fromJson(Map<String, dynamic>.from(e['meal'])))
        .toList();
  }

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

  Future<void> toggleFavorite(String userId, Meal meal) async {
    final existing =
        await supabase
            .from('favorites')
            .select('id')
            .eq('user_id', userId)
            .eq('meal_id', meal.id)
            .maybeSingle();

    if (existing == null) {
      await supabase.from('favorites').insert({
        'user_id': userId,
        'meal_id': meal.id,
      });
    } else {
      await supabase.from('favorites').delete().eq('id', existing['id']);
    }
  }

  Future<void> addFavorite(String userId, String mealId) async {
    await supabase.from('favorites').insert({
      'user_id': userId,
      'meal_id': mealId,
    });
  }
}
