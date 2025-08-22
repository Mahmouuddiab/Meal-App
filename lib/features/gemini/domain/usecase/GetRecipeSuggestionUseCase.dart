import 'package:meal_app/features/gemini/data/models/ai_meal_model.dart';
import 'package:meal_app/features/gemini/data/models/image_model.dart';
import 'package:meal_app/features/gemini/data/repository/recipe_repository.dart';

class GetRecipeSuggestionUseCase {
  final RecipeRepository recipeRepository;

  GetRecipeSuggestionUseCase(this.recipeRepository);

  Future<AIMeal> call(String ingredients) {
    return recipeRepository.getRecipeSuggestions(ingredients);
  }


  Future<ImageModel> callGetImage(String dishName) {
    return recipeRepository.getDishImage(dishName);
  }
}