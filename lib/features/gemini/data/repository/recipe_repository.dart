import 'package:meal_app/features/gemini/data/dataSource/recipe_remote_data_source.dart';
import 'package:meal_app/features/gemini/data/models/ai_meal_model.dart';
import 'package:meal_app/features/gemini/data/models/image_model.dart';

class RecipeRepository {
  final RecipeRemoteDatasource remoteDatasource;

  RecipeRepository(this.remoteDatasource);

  Future<AIMeal> getRecipeSuggestions(String ingredients) async {
    final result = await remoteDatasource.getRecipeSuggestions(ingredients);
    return AIMeal(
        name: result.name,
        mealType: result.mealType,
        rating: result.rating,
        cookTime: result.cookTime,
        servingSize: result.servingSize,
        summary: result.summary,
        ingredients: result.ingredients,
        mealSteps: result.mealSteps);
  }


  ///Fetch Dish Name Image (Ahmed)
  Future<ImageModel> getDishImage(String dishName)async {
    final result=await remoteDatasource.getDishImage(dishName);
    return result;
  }

}
